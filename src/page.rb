require_relative "./page"

class Page < Page
  attr_accessor :next_page_link, :previous_page_link, :post_links

  def initialize(page_link, page_html)
    super(page_link, page_html)
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: @post_links,
    }.to_json
  end
end
