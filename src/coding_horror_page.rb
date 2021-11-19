require_relative './coding_horror_post'
require_relative './page'

class CodingHorrorPage < Page
  def initialize(page_html)
    @current_page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @posts = CodingHorrorPost.new(page_html)
  end
end

