require 'json'
require_relative './coding_horror_post'
require_relative './page'
require 'pry-byebug'

class CodingHorrorPage < Page
  def initialize(page_html)
    @page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end

  def self.start(page_link)
    pages_file = ENV["PAGES_FILE"]
    fetch_page_recursive(pages_file, page_link, ENV["DIRECTION"])
  end

  def self.fetch_page_recursive(pages_file, page_link, direction="normal")
    page = fetch_page(pages_file, page_link)
    if direction == 'reverse'
      fetch_page_recursive(pages_file, ENV["PAGE_BASE_URL"] + page.next_page_link, "reverse")
    else
      fetch_page_recursive(pages_file, ENV["PAGE_BASE_URL"] + page.previous_page_link)
    end
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

