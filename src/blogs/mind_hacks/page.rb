require 'json'
require_relative '../../page'
require 'pry-byebug'

class MindHacksPage < Page
  def initialize(page_link, page_html)
    @page_link = page_link
    current_page_number = page_html.css(".page_pagination .current").text.to_i
    @next_page_link = "#{Config.blog['base_url']}/page/#{current_page_number + 1}/"
    @previous_page_link = "#{Config.blog['base_url']}/page/#{current_page_number - 1}/"
    @post_links = page_html.css(".entry-title a").map {|a| a.attributes["href"].value }
  end
end

