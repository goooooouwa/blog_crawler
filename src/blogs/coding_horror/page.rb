require 'json'
require_relative '../../page'
require 'pry-byebug'

class CodingHorrorPage < Page
  def initialize(page_link, page_html)
    blog_config = JSON.parse(File.read(File.join(File.dirname(__FILE__), './blog.json'))

    @page_link = page_link
    @page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = blog_config["BLOG_BASE_URL"] + next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = blog_config["BLOG_BASE_URL"] + previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: [@page_link]
    }.to_json
  end
end

