require_relative './page_fetcher'

class Post
  extend PageFetcher
  attr_accessor :page_link, :title, :published_date, :content, :author

  def self.start
    pages_file = ENV["PAGES_FILE"]
    posts_file = ENV["POSTS_FILE"]
    fetch_posts_by_page(pages_file, posts_file)
  end

  def self.fetch_posts_by_page(pages_file, posts_file)
    pages = JSON.parse(File.open(pages_file).read)
    pages.each do |page|
      page["post_links"].each do |post_link|
        begin
          fetch_page(posts_file, post_link)
        rescue PageDuplicationError
          # skip to next post
        end
      end
    end
  end

end
