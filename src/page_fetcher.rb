require 'nokogiri'
require 'uri'
require 'net/http'
require 'json'
require 'pry-byebug'
require 'logger'
require 'dotenv/load'

module PageFetcher
  @@logger = Logger.new(ENV["LOG_FILE"] || STDOUT)

  def fetch_page(pages_file, page_link, retry_count=0)
    @@logger.info("processing: #{page_link}")
    raise StandardError.new "Error: page #{page_link} failed to load for #{MAX_RETRY_COUNT} times" if retry_count >= ENV["MAX_RETRY_COUNT"].to_i

    pages = JSON.parse(File.open(pages_file).read)
    duplicates = pages.select {|page| page["page_link"] == page_link }
    unless duplicates.empty?
      @@logger.debug("duplicate page_link: #{page_link}")
      return duplicates.first
    end

    res = Net::HTTP.get_response(URI(page_link))
    if res.is_a?(Net::HTTPSuccess)
      page_html = Nokogiri::HTML.parse(res.body)
      page = new(page_link, page_html)
      pages.push(page)
      @@logger.debug("saving page: #{page.inspect}")
      File.open(pages_file, 'w') { |file| file.write(JSON.generate(pages)) }
      return page
    else
      @@logger.debug("request failed: #{res.inspect}")
      fetch_page(pages_file, page_link, retry_count + 1)
    end
  end
end
