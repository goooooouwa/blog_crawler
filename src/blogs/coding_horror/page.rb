require 'json'
require_relative '../../page'
require 'pry-byebug'

class CodingHorrorPage < Page
  def initialize(page_link, page_html)
    @page_link = page_link
    @page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = Config.blog['base_url'] + next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = Config.blog['base_url'] + previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end
end

