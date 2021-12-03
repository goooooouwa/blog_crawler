require_relative './page_fetcher'

class Post
  extend PageFetcher
  attr_accessor :page_link, :title, :published_date, :content, :author

  def self.start(pages_file='./out/pages.json', posts_file='./out/posts.json')
    fetch_posts_by_page(pages_file, posts_file)
  end

  def self.fetch_posts_by_page(pages_file, posts_file)
    pages = JSON.parse(File.open(pages_file).read)
    pages.each do |page|
      page["post_links"].each do |post_link|
        fetch_page(posts_file, post_link)
      end
    end
  end

  def to_json(_)
    {
      page_link: @page_link,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author
    }.to_json
  end
end
