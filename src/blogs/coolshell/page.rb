require 'json'
require_relative '../../page'
require 'pry-byebug'

class CoolshellPage < Page
  def initialize(page_link, page_html)
    blog_config = JSON.parse(File.read(File.join(File.dirname(__FILE__), './blog.json')))

    @page_link = page_link
    current_page_number = page_html.css(".wp-pagenavi .current").text.to_i
    @next_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number + 1}"
    @previous_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number - 1}"
    @post_links = page_html.css(".entry-title a").map {|a| a.attributes["href"].value }
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

