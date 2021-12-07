class Page
  attr_accessor :page_link, :page_html

  def initialize(page_link, page_html)
    @page_link = page_link
    @content = page_html
  end

  def to_json(_)
    {
      page_link: @post_link,
      content: @content,
    }.to_json
  end
end
