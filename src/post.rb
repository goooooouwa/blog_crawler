class Post
  def initialize(post_url, post_html)
    @post_url = post_url
    @post_html = post_html
    @title = nil
    @published_date = nil
    @content = nil
    @author = nil
  end

  def to_json(_)
    {
      page_url: @post_url,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author,
    }.to_json
  end
end
