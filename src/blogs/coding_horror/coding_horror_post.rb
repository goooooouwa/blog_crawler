require 'json'
require_relative '../../post'

class CodingHorrorPost < Post
  def initialize(post_link, post_html)
    super(post_link, post_html)
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end
end
