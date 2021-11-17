require 'json'

def start
  rss_items_file = './rss_items.json'
  rss_items = JSON.parse(File.open(rss_items_file).read)
  rss_items.each do |rss_item|
    render_rss_item(rss_item)
  end
end

def render_rss_item(rss_item)
result = <<-ITEM
<item>
<title>#{rss_item["title"]}</title>
<link>#{rss_item["link"]}</link>
<content>#{rss_item["content"]}</content>
<pubDate>#{rss_item["published_date"]}</pubDate>
<guid>#{rss_item["link"]}</guid>
</item>
ITEM

  puts result
end

start
