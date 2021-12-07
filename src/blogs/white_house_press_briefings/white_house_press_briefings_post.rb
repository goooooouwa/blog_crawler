require "json"
require "date"
require_relative "../../post"

class WhiteHousePressBriefingsPost < Post
  def initialize(post_link, post_html)
    super(post_link, page_html)
    @title = post_html.css("#media-detail #video-info .caption h1").text
    @published_date = DateTime.parse(post_link.match(/[0-9]{4}\/[0-9]{2}\/[0-9]{2}/)[0])
    @content = post_html.css("#media-detail #video-info .download a")[1].attributes["href"].value
    @author = "the White House"
  end
end
