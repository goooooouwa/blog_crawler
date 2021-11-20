require 'json'
require_relative '../page'
require 'pry-byebug'

class Matrix67Page < Page
  def initialize(page_link, page_html)
    @page_link = page_link
    match_data = page_link.match(/page\/[0-9]{1,3}/)
    current_page_number = match_data.nil? ? 1 : match_data[0].split('/').last.to_i
    @next_page_link = "#{ENV['PAGE_BASE_URL']}/page/#{current_page_number + 1}"
    @previous_page_link = "#{ENV['PAGE_BASE_URL']}/page/#{current_page_number - 1}"
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

