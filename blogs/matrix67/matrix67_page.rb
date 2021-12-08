require "json"
require_relative "../../src/page"

class Matrix67Page < Page
  def initialize(page_link, page_html)
    super(page_link, page_html)
    match_data = page_link.match(/page\/[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split("/").last.to_i
    @next_page_link = "http://www.matrix67.com/blog/page/#{current_page_number + 1}"
    @previous_page_link = "http://www.matrix67.com/blog/page/#{current_page_number - 1}"
    @post_links = page_html.css(".entry-title a").map { |a| a.attributes["href"].value }
  end
end
