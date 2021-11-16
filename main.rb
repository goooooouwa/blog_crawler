require 'nokogiri'

# html        = "<title>test</title>actual content here..."
file = File.open("./data/source.html")
html = file.read
parsed_data = Nokogiri::HTML.parse(html)

articles = parsed_data.css(".article_archived")


blog = "Coding Horror"

rss_items = []

articles.each do |article|
  org_published_date = article.css(".article_tile_header_date").first.attributes["title"].value
  processed_published_date = org_published_date.split("\n").last.split(": ").last
  link = article.css(".article_title_link").first.attributes["href"].value
  title = article.css(".article_title_link").first.text
  author = "Jeff Atwood"

rss_item = <<-ITEM
<item>
<title>#{title}</title>
<link>#{link}</link>
<description></description>
<pubDate>#{processed_published_date}</pubDate>
<guid>#{link}</guid>
</item>
ITEM

  puts rss_item
end
