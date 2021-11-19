require_relative './post'

class CodingHorrorPost < Post
  def fetch_post(post_link)
    @link = post_html.at("meta[property='og:url']")['content']
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end
end
