require_relative './page_fetcher'

class Page
  extend PageFetcher
  attr_accessor :page_link, :next_page_link, :previous_page_link, :post_links

  def self.start(page_link, pages_file='./out/pages.json')
    fetch_page_recursive(pages_file, page_link, ENV["DIRECTION"])
  end

  def self.fetch_page_recursive(pages_file, page_link, direction="next")
    page = fetch_page(pages_file, page_link)
    if direction == 'previous'
      fetch_page_recursive(pages_file, page.previous_page_link, "previous")
    else
      fetch_page_recursive(pages_file, page.next_page_link)
    end
  end

end
