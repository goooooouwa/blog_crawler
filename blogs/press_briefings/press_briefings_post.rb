require "json"
require "date"
require_relative "../../src/post"

class PressBriefingsPost < Post
  def initialize(post_url, post_html)
    super(post_url, post_html)
    @title = post_html.css("#media-detail #video-info .caption h1").text
    @published_date = DateTime.parse(post_html.css("#media-detail #video-info .caption .notes").text)
    mp3_download_link = post_html.css("#media-detail #video-info .download a").detect { |a| a.attributes["href"].value.include? "mp3" }
    @content = mp3_download_link.nil? ? nil : mp3_download_link.attributes["href"].value
    @author = "the White House"
  end
end
