require "json"
require "date"
require_relative "../../post"

class PressBriefingsPost < Post
  def initialize(post_link, post_html)
    super(post_link, post_html)
    @title = post_html.css("#media-detail #video-info .caption h1").text
    @published_date = DateTime.parse(post_html.css("#media-detail #video-info .date-display-single").text)
    mp3_download_link = post_html.css("#media-detail #video-info .download a").detect { |a| a.attributes["href"].value.include? "mp3" }
    @content = mp3_download_link.nil? ? nil : mp3_download_link.attributes["href"].value
    @author = "the White House"
  end
end
