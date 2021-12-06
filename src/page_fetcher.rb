require 'nokogiri'
require 'uri'
require 'net/http'
require 'json'
require 'logger'

module PageFetcher
  @@logger = Logger.new(ENV["LOG_FILE"] || STDOUT)

  def fetch_page(page_link, retry_count=0)
    @@logger.info("processing: #{page_link}")
    if retry_count >= ENV['MAX_RETRY_COUNT'].to_i
      raise StandardError.new "Error: page #{page_link} failed to load for #{ENV['MAX_RETRY_COUNT']} times"
    end

    pages = JSON.parse(File.open(ENV['PAGES_FILE']).read)
    duplicates = pages.select {|page| page["page_link"] == page_link }
    unless duplicates.empty?
      @@logger.debug("skipping duplicate page: #{page_link}")
      return duplicates.first
    end

    res = Net::HTTP.get_response(URI(page_link))
    if res.is_a?(Net::HTTPSuccess)
      page_html = Nokogiri::HTML.parse(res.body)
      page = new(page_link, page_html)
      pages.push(page)
      @@logger.debug("saving page: #{page.inspect}")
      File.open(ENV['PAGES_FILE'], 'w') { |file| file.write(JSON.generate(pages)) }
      return JSON.parse(JSON.generate(page))
    else
      @@logger.debug("request failed: #{res.inspect}")
      fetch_page(page_link, retry_count + 1)
    end
  end
end
