require 'json'
require_relative '../../page'
require 'pry-byebug'

class MaccastPage < Page
  def initialize(page_link, page_html)
    blog_config = JSON.parse(File.read(File.join(File.dirname(__FILE__), './blog.json'))
    
    @page_link = page_link

    match_data = page_link.match(/page\/[0-9]{1,3}\//)
    current_page_number = match_data.nil? ? 1 : match_data[0].split('/').last.to_i
    @next_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number + 1}/"
    @previous_page_link = "#{blog_config['BLOG_BASE_URL']}/page/#{current_page_number - 1}/"
    
    @post_links = page_html.css(".postheadline .h2").map {|a| a.attributes["href"].value }
    
    @post_entries = page_html.css(".post").map do |post_html|
      post_link = post_html.css(".postheadline .h2")[0].attributes["href"].value
      {
        page_link: post_link,
        title: post_html.css(".postheadline .h2").text,
        published_date: DateTime.parse(post_link.match(/[0-9]{4}\/[0-9]{2}\/[0-9]{2}/)[0]),
        content: post_html.css(".entry").children,
        author: "Adam Christianson",
      }
    end
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: @post_links,
      post_entries: @post_entries
    }.to_json
  end
end

