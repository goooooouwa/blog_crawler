require "json"
require_relative "../../src/page"

class Matrix67Page < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)
    match_data = page_url.match(/page\/[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split("/").last.to_i
    @next_page_url = "http://www.matrix67.com/blog/page/#{current_page_number + 1}"
    @previous_page_url = "http://www.matrix67.com/blog/page/#{current_page_number - 1}"
    @post_urls = page_html.css(".entry-title a").map { |a| a.attributes["href"].value }
  end
end
