class Page
  def initialize(page_url, page_html)
    @page_url = page_url
    @page_html = page_html
    @previous_page_url = nil
    @next_page_url = nil
    @post_urls = []
  end

  def to_json(_)
    {
      page_url: @page_url,
      previous_page_url: @previous_page_url,
      next_page_url: @next_page_url,
      post_urls: @post_urls,
    }.to_json
  end
end
