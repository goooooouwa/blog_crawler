require 'json'

def start
  rss_items_file = './rss_items.json'
  rss_items = JSON.parse(File.open(rss_items_file).read)
  rss_items.sort_by { |hs| hs["published_date"] }.reverse.each_slice(14).with_index do |slice, index|
    rss_content = ''
    slice.each do |rss_item|
      rss_content.concat(render_rss_item(rss_item))
    end
    rss_slice_feed = render_rss_header + rss_content + render_rss_footer
    File.open("./out/feeds.txt", 'a') { |file| file.write("https://raw.githubusercontent.com/goooooouwa/htmlparser/master/out/slice-#{index}.xml\n") }
    File.open("./out/slice-#{index}.xml", 'w') { |file| file.write(rss_slice_feed) }
  end
end

def render_rss_footer
  <<-FOOTER
</channel>
</rss>
FOOTER
end

def render_rss_header
  <<-HEADER
result = <<-ITEM
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>Coding Horror</title>
<description>programming and human factors</description>
<link>https://blog.codinghorror.com/</link>
<pubDate>Sun, 19 Apr 2020 00:00:01 GMT</pubDate>
<!-- other elements omitted from this example -->
HEADER
end

def render_rss_item(rss_item)
<<-ITEM
<item>
<title>#{rss_item["title"]}</title>
<link>#{rss_item["link"]}</link>
<content>#{rss_item["content"]}</content>
<pubDate>#{rss_item["published_date"]}</pubDate>
<guid>#{rss_item["link"]}</guid>
</item>
ITEM
end

start
