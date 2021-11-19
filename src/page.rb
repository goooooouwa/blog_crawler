require_relative './page_fetcher'

class Page
  include PageFetcher
  attr_accessor :link, :next_page_link, :previous_page_link, :post_links, :posts

end
