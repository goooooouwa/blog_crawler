require_relative "./url_downloader"

class PageFetcher < URLDownloader
  def initialize(page_class, pages_file)
    super(pages_file)
    @page_class = page_class
  end

  def start(initial_page, direction)
    fetch_page_recursive(initial_page, direction)
  end

  def fetch_page_recursive(page_url, direction = "next")
    page = self.save_page(page_url) do |page_html|
      @page_class.new(page_url, page_html)
    end

    if direction == "previous"
      fetch_page_recursive(page["previous_page_url"], "previous")
    else
      fetch_page_recursive(page["next_page_url"])
    end
  end
end
