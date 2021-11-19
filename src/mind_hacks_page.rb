require 'json'
require_relative './mind_hacks_post'
require_relative './page'
require 'pry-byebug'

class MindHacksPage < Page
  def initialize(page_link, page_html)
    @page_link = page_link
    current_page_number = page_html.css(".page_pagination .current").text.to_i
    @next_page_link = "#{ENV['PAGE_BASE_URL']}/page/#{current_page_number + 1}/"
    @previous_page_link = "#{ENV['PAGE_BASE_URL']}/page/#{current_page_number - 1}/"
    @post_links = page_html.css(".entry-title a").map {|a| a.attributes["href"].value }
  end

  def self.start(page_link)
    pages_file = ENV["PAGES_FILE"]
    fetch_page_recursive(pages_file, page_link, ENV["DIRECTION"])
  end

  def self.fetch_page_recursive(pages_file, page_link, direction="normal")
    page = fetch_page(pages_file, page_link)
    if direction == 'reverse'
      fetch_page_recursive(pages_file, page.previous_page_link, "reverse")
    else
      fetch_page_recursive(pages_file, page.next_page_link)
    end
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: @post_links
    }.to_json
  end
end

