require "json"
require_relative "../../list_page"
require "pry-byebug"

class CodingHorrorListPage < ListPage
  def initialize(page_link, page_html, base_url)
    super(page_link, page_html)
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = base_url + next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = base_url + previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end
end
