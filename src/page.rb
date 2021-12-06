require_relative './page_fetcher'

class Page
  extend PageFetcher
  attr_accessor :page_link, :next_page_link, :previous_page_link, :post_links

  def self.start
    fetch_page_recursive(Config.config['blog']['initial_page'], Config.config['blog']["direction"])
  end

  def self.fetch_page_recursive(page_link, direction="next")
    page = fetch_page(page_link)
    if direction == 'previous'
      fetch_page_recursive(page["previous_page_link"], "previous")
    else
      fetch_page_recursive(page["next_page_link"])
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
