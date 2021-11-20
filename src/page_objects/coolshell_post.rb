require 'json'
require 'date'
require_relative '../post'

class CoolshellPost < Post
  def initialize(post_link, post_html)
    @page_link = post_link
    @title = post_html.css(".entry-title").text
    @published_date = post_html.css(".entry-date").first.attributes["datetime"].value
    @content = post_html.css(".entry-content").children
    @author = "陈皓"
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
