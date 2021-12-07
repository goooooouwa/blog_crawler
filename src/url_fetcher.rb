require "nokogiri"
require "uri"
require "net/http"
require "json"
require_relative "./logging"

class URLFetcher
  def initialize(pages_file, max_retry_count=5)
    @pages_file = pages_file
    @max_retry_count = max_retry_count
  end

  def fetch_url(page_link, retry_count = 0)
    Logging.logger.info("processing: #{page_link}")
    if retry_count >= @max_retry_count
      raise StandardError.new "Error: page #{page_link} failed to load for #{@max_retry_count} times"
    end

    pages = JSON.parse(File.read(@pages_file))
    duplicates = pages.select { |page| page["page_link"] == page_link }
    unless duplicates.empty?
      Logging.logger.debug("skipping duplicate page: #{page_link}")
      return duplicates.first
    end

    res = Net::HTTP.get_response(URI(page_link))
    if res.is_a?(Net::HTTPSuccess)
      page_html = Nokogiri::HTML.parse(res.body)
      page = yield(page_html)
      pages.push(page)
      Logging.logger.debug("saving page: #{page.inspect}")
      File.open(@pages_file, "w") { |file| file.write(JSON.generate(pages)) }
      return JSON.parse(JSON.generate(page))
    else
      Logging.logger.debug("request failed: #{res.inspect}")
      fetch_url(page_link, retry_count + 1)
    end
  end
end
