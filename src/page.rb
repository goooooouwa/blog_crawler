require_relative './page_fetcher'

class Page
  extend PageFetcher
  attr_accessor :page_link, :next_page_link, :previous_page_link, :post_links

end
