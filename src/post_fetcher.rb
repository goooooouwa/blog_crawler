require "date"
require_relative "./url_downloader"

class PostFetcher < URLDownloader
  def initialize(post_class, posts_file, list_pages_file, max_retry_count = 5)
    @page_class = post_class
    @save_file = posts_file
    @list_pages_file = list_pages_file
    @max_retry_count = max_retry_count
  end

  def start
    list_pages = JSON.parse(File.open(@list_pages_file).read)
    list_pages.each do |list_page|
      list_page["post_links"].each do |post_link|
        save_as_page(post_link) do |page_html|
          @page_class.new(post_link, page_html)
        end
      end
    end
  end
end
