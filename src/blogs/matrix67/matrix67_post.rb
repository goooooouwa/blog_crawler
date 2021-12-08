require 'json'
require 'date'
require_relative '../../post'

class Matrix67Post < Post
  def initialize(post_link, post_html)
    super(post_link, post_html)
    @title = post_html.css(".entry-title").text
    @published_date = post_html.css(".entry-date").first.attributes["datetime"].value
    @content = post_html.css(".entry-content").children
    @author = "顾森"
  end
end
