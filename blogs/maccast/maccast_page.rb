require "json"
require_relative "../../src/page"
require "pry-byebug"

class MaccastPage < Page
  def initialize(page_url, page_html)
    super(page_url, page_html)

    match_data = page_url.match(/page\/[0-9]{1,3}\//)
    current_page_number = match_data.nil? ? 1 : match_data[0].split("/").last.to_i
    @next_page_url = "https://www.maccast.com/category/podcast/page/#{current_page_number + 1}/"
    @previous_page_url = "https://www.maccast.com/category/podcast/page/#{current_page_number - 1}/"

    @post_urls = page_html.css(".postheadline .h2").map { |a| a.attributes["href"].value }
    @post_entries = page_html.css(".post").map do |post_html|
      post_url = post_html.css(".postheadline .h2")[0].attributes["href"].value
      {
        page_url: post_url,
        title: post_html.css(".postheadline .h2").text,
        published_date: DateTime.parse(post_url.match(/[0-9]{4}\/[0-9]{2}\/[0-9]{2}/)[0]),
        content: post_html.css(".entry").children,
        author: "Adam Christianson",
      }
    end
  end

  def to_json(_)
    {
      page_url: @page_url,
      previous_page_url: @previous_page_url,
      next_page_url: @next_page_url,
      post_urls: @post_urls,
      post_entries: @post_entries,
    }.to_json
  end
end
