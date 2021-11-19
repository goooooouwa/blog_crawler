require 'json'
require_relative './post'

class MindHacksPost < Post
  def initialize(post_link, post_html)
    @page_link = post_link
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end

  def self.start
    pages_file = ENV["PAGES_FILE"]
    posts_file = ENV["POSTS_FILE"]
    fetch_posts_by_page(pages_file, posts_file)
  end

  def self.fetch_posts_by_page(pages_file, posts_file)
    pages = JSON.parse(File.open(pages_file).read)
    pages.each do |page|
      page["post_links"].each do |post_link|
        fetch_page(posts_file, post_link)
      end
    end
  end

  def to_json(_)
    {
      page_link: @page_link,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author
    }.to_json
  end
end
