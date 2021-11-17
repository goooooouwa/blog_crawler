require 'nokogiri'
require 'date'
require 'uri'
require 'net/http'
require 'json'
require "pry-byebug"


def start
  rss_items_file = './rss_items.json'
  link = 'https://blog.codinghorror.com/of-white-elephants-and-gifting/'
  fetch_content(rss_items_file, link)
end

def fetch_content(rss_items_file, link, retry_count=0)
  puts "processing: #{link}"
  max_retry_count = 5
  raise StandardError.new "max retry count #{max_retry_count} exceeded for #{link}" if retry_count == max_retry_count

  rss_items = JSON.parse(File.open(rss_items_file).read)
  duplicates = rss_items.select {|item| item["link"] == link }
  # return duplicates.first unless duplicates.empty?
  raise StandardError.new "duplicate link: #{link}" unless duplicates.empty?

  res = Net::HTTP.get_response(URI(link))
  # binding.pry
  if res.is_a?(Net::HTTPSuccess)
    article = Nokogiri::HTML.parse(res.body)
    rss_item = {
      link: link,
      previous_link: article.css(".right .read-next-title a").first.attributes["href"].value,
      title: article.css(".post-title").text,
      published_date: article.at("meta[property='article:published_time']")['content'],
      content: article.css(".post-content").children,
      author: "Jeff Atwood"
    }
    rss_items.push(rss_item)
    File.open(rss_items_file, 'w') { |file| file.write(JSON.generate(rss_items)) }
    base_url = 'https://blog.codinghorror.com'
    fetch_content(rss_items_file, base_url + rss_item[:previous_link])
  else
    puts "request failed: #{res.inspect.to_s}"
    fetch_content(rss_items_file, link, retry_count + 1)
  end
end

start
