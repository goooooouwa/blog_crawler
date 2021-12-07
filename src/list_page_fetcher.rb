require_relative "./url_fetcher"

class ListPageFetcher < URLFetcher
  def initialize(page_class, pages_file, base_url, max_retry_count=5)
    @page_class = page_class
    @pages_file = pages_file
    @base_url = base_url
    @max_retry_count = max_retry_count
  end

  def start(initial_page, direction)
    fetch_page_recursive(initial_page, direction)
  end

  def fetch_page_recursive(page_link, direction = "next")
    page = fetch_url(page_link) do |page_html|
      @page_class.new(page_link, page_html, @base_url)
    end

    if direction == "previous"
      fetch_page_recursive(page["previous_page_link"], "previous")
    else
      fetch_page_recursive(page["next_page_link"])
    end
  end
end
