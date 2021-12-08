class Page
  def initialize(page_link, page_html)
    @page_link = page_link
    @page_html = page_html
    @previous_page_link = nil
    @next_page_link = nil
    @post_links = []
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
