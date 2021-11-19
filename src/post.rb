require_relative './page_fetcher'

class Post
  extend PageFetcher
  attr_accessor :page_link, :title, :published_date, :content, :author

end
