require_relative './page_fetcher'

class Page
  extend PageFetcher
  attr_accessor :page_link, :next_page_link, :previous_page_link, :post_links

  def self.start(pages_file='./out/pages.json', page_link)
    page_link = self.blog_config['INITIAL_PAGE'] if page_link.nil?
    fetch_page_recursive(pages_file, page_link, ENV["DIRECTION"])
  end

  def self.fetch_page_recursive(pages_file, page_link, direction="next")
    page = fetch_page(pages_file, page_link)
    if direction == 'previous'
      fetch_page_recursive(pages_file, page["previous_page_link"], "previous")
    else
      fetch_page_recursive(pages_file, page["next_page_link"])
    end
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: @post_links
    }.to_json
  end
end
