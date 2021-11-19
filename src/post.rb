require_relative './page_fetcher'

class Post
  include PageFetcher
  attr_accessor :page_link, :title, :published_date, :content, :author

end
