require "json"
require_relative "../../src/page"
require "pry-byebug"

class MindHacksPage < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)
    current_page_number = page_html.css(".page_pagination .current").text.to_i
    @next_page_url = "https://mindhacks.cn/page/#{current_page_number + 1}/"
    @previous_page_url = "https://mindhacks.cn/page/#{current_page_number - 1}/"
    @post_urls = page_html.css(".entry-title a").map { |a| a.attributes["href"].value }
  end
end
