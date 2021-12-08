require "nokogiri"
require "uri"
require "net/http"
require "json"
require_relative "./logging"

class URLDownloader
  attr_accessor :max_retry_count

  def initialize(save_file)
    @save_file = save_file
    @max_retry_count = 5
  end

  def save_page(url, retry_count = 0)
    Logging.logger.info("processing: #{url}")
    if retry_count >= @max_retry_count
      raise StandardError.new "Error: page #{url} failed to load for #{@max_retry_count} times"
    end

    pages = JSON.parse(File.read(@save_file))
    duplicates = pages.select { |page| page["page_link"] == url }
    unless duplicates.empty?
      Logging.logger.debug("skipping duplicate page: #{url}")
      return duplicates.first
    end

    res = Net::HTTP.get_response(URI(url))
    if res.is_a?(Net::HTTPSuccess)
      page_html = Nokogiri::HTML.parse(res.body)
      page = yield(page_html)
      pages.push(page)
      Logging.logger.debug("saving page: #{page.inspect}")
      File.open(@save_file, "w") { |file| file.write(JSON.generate(pages)) }
      return JSON.parse(JSON.generate(page))
    else
      Logging.logger.debug("request failed: #{res.inspect}")
      save_page(url, retry_count + 1)
    end
  end
end
