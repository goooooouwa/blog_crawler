require_relative "./page"

class Post < Page
  attr_accessor :title, :published_date, :content, :author

  def initialize(post_link, page_html)
    super(post_link, page_html)
  end

  def to_json(_)
    {
      page_link: @page_link,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author,
    }.to_json
  end
end
