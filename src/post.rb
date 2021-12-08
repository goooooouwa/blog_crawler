class Post
  def initialize(post_link, post_html)
    @post_link = post_link
    @post_html = post_html
    @title = nil
    @published_date = nil
    @content = nil
    @author = nil
  end

  def to_json(_)
    {
      post_link: @post_link,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author,
    }.to_json
  end
end
