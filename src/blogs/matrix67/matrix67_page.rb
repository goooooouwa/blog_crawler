require "json"
require_relative "../../page"

class Matrix67Page < Page
  def initialize(page_link, page_html, base_url)
    super(page_link, page_html)
    match_data = page_link.match(/page\/[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split("/").last.to_i
    @next_page_link = "#{base_url}/page/#{current_page_number + 1}"
    @previous_page_link = "#{base_url}/page/#{current_page_number - 1}"
    @post_links = page_html.css(".entry-title a").map { |a| a.attributes["href"].value }
  end
end
