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
    raise StandardError.new "max retry count exceeded for #{page_link}" if retry_count == ENV["MAX_RETRY_COUNT"]

    pages = JSON.parse(File.open(pages_file).read)
    duplicates = pages.select {|page| page["page_link"] == page_link }
    unless duplicates.empty?
      @@logger.debug("duplicate page: #{duplicates.first.inspect}")
      raise StandardError.new "duplicate page_link: #{page_link}" unless duplicates.empty?
    end

    res = Net::HTTP.get_response(URI(page_link))
    if res.is_a?(Net::HTTPSuccess)
      page_html = Nokogiri::HTML.parse(res.body)
      page = new(page_html)
      pages.push(page)
      @@logger.debug("saving page: #{page.inspect}")
      File.open(pages_file, 'w') { |file| file.write(JSON.generate(pages)) }
      page
    else
      @@logger.debug("request failed: #{res.inspect}")
      fetch_page(pages_file, page_link, retry_count + 1)
    end
  end
end
