require 'json'
require_relative '../../page'
require 'pry-byebug'

class Matrix67Page < Page
  def initialize(page_link, page_html)
    blog_config = JSON.parse(File.read(File.join(File.dirname(__FILE__), './blog.json')))

    @page_link = page_link
    match_data = page_link.match(/page\/[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split('/').last.to_i
    @next_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number + 1}"
    @previous_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number - 1}"
    @post_links = page_html.css(".entry-title a").map {|a| a.attributes["href"].value }
  end

  end
end

