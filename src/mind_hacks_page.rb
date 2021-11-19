require './mind_hacks_post'
require './page'

class MindHacksPage < Page
  def initialize(page_html)
    @current_page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
      post_links = page_html.css(".entry-title a")
    @posts = CodingHorrorPost.new(page_html)
  end
end
