require "json"
require_relative "../../src/page"
require "pry-byebug"

class CodingHorrorPage < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)
    next_page_url_node = page_html.css(".left .read-next-title a").first
    previous_page_url_node = page_html.css(".right .read-next-title a").first
    @next_page_url = "https://blog.codinghorror.com#{ next_page_url_node.attributes["href"].value }" unless next_page_url_node.nil?
    @previous_page_url = "https://blog.codinghorror.com#{ previous_page_url_node.attributes["href"].value }" unless previous_page_url_node.nil?
    @post_urls = [@page_url]
  end
end
