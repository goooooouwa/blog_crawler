require "date"
require_relative "./url_downloader"

class PostFetcher < URLDownloader
  def initialize(post_class, posts_file, pages_file)
    super(posts_file)
    @post_class = post_class
    @pages_file = pages_file
  end

  def start
    pages = JSON.parse(File.open(@pages_file).read)
    pages.each do |page|
      page["post_links"].each do |post_link|
        self.save_page(post_link) do |post_html|
          @post_class.new(post_link, post_html)
        end
      end
    end
  end
end
