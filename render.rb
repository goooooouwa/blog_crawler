require 'json'

def start
  rss_items_file = './rss_items.json'
  rss_items = JSON.parse(File.open(rss_items_file).read)
  rss_items.each_with_index do |rss_item, index|
    render_rss_item(rss_item, index)
  end
end

def render_rss_item(rss_item, index)
result = <<-ITEM
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>Coding Horror</title>
<description>programming and human factors</description>
<link>https://blog.codinghorror.com/</link>
<pubDate>Sun, 19 Apr 2020 00:00:01 GMT</pubDate>
<!-- other elements omitted from this example -->
<item>
<title>#{rss_item["title"]}</title>
<link>#{rss_item["link"]}</link>
<content>#{rss_item["content"]}</content>
<pubDate>#{rss_item["published_date"]}</pubDate>
<guid>#{rss_item["link"]}</guid>
</item>
</channel>
</rss>
ITEM

File.open("./out/out", 'a') { |file| file.write("https://raw.githubusercontent.com/goooooouwa/htmlparser/master/out/out-#{index}.xml\n") }
  File.open("./out/out-#{index}.xml", 'w') { |file| file.write(result) }
end

start
