require 'nokogiri'
require 'date'
require 'uri'
require 'net/http'
require 'json'
require "pry-byebug"
require "logger"
require 'dotenv/load'

class Fetcher
  @@logger = Logger.new(ENV["LOG_FILE"] || STDOUT)

  def self.start
    @@logger.info("Start")
    rss_items_file = ENV["RSS_ITEMS_FILE"]
    fetch_content(rss_items_file, ARGV[0], 0, ENV["DIRECTION"])
  end

  def self.fetch_content(rss_items_file, link, retry_count=0, direction="normal")
    @@logger.info("processing: #{link}")
    raise StandardError.new "max retry count exceeded for #{link}" if retry_count == ENV["MAX_RETRY_COUNT"]

    rss_items = JSON.parse(File.open(rss_items_file).read)
    duplicates = rss_items.select {|item| item["link"] == link }
    unless duplicates.empty?
      @@logger.debug("duplicate item: #{duplicates.first.dup.tap { |hs| hs.delete('content') }.inspect}")
      raise StandardError.new "duplicate link: #{link}" unless duplicates.empty?
    end

    res = Net::HTTP.get_response(URI(link))
    if res.is_a?(Net::HTTPSuccess)
      article = Nokogiri::HTML.parse(res.body)
      next_link_node = article.css(".left .read-next-title a").first
      previous_link_node = article.css(".right .read-next-title a").first
      rss_item = {
        link: link,
        next_link: (next_link_node.attributes["href"].value unless next_link_node.nil?),
        previous_link: (previous_link_node.attributes["href"].value unless previous_link_node.nil?),
        title: article.css(".post-title").text,
        published_date: article.at("meta[property='article:published_time']")['content'],
        content: article.css(".post-content").children,
        author: "Jeff Atwood"
      }
      rss_items.push(rss_item)
      File.open(rss_items_file, 'w') { |file| file.write(JSON.generate(rss_items)) }
      @@logger.debug("rss item: #{rss_item.dup.tap { |hs| hs.delete('content') }.inspect}")
      if direction == 'reverse'
        fetch_content(rss_items_file, ENV["BASE_URL"] + rss_item[:next_link], 0, "reverse")
      else
        fetch_content(rss_items_file, ENV["BASE_URL"] + rss_item[:previous_link])
      end
    else
      @@logger.debug("request failed: #{res.inspect}")
      fetch_content(rss_items_file, link, retry_count + 1)
    end
  end
end

Fetcher.start
