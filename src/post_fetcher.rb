require "date"
require_relative "./url_downloader"

class PostFetcher < URLDownloader
  def initialize(post_class, posts_file, pages_file, max_retry_count = 5)
    @page_class = post_class
    @save_file = posts_file
    @pages_file = pages_file
    @max_retry_count = max_retry_count
  end

  def start
    pages = JSON.parse(File.open(@pages_file).read)
    pages.each do |page|
      page["post_links"].each do |post_link|
        save_as_page(post_link) do |page_html|
          @page_class.new(post_link, page_html)
        end
      end
    end
  end
end
