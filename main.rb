require 'nokogiri'
require 'date'
require 'uri'
require 'net/http'

# html        = "<title>test</title>actual content here..."
file = File.open("./source.html")
html = file.read
parsed_data = Nokogiri::HTML.parse(html)

articles = parsed_data.css(".article_archived")


blog = "Coding Horror"

rss_items = []

articles.each do |article|
  org_published_date = article.css(".article_tile_header_date").first.attributes["title"].value
  processed_published_date = DateTime.parse(org_published_date.split("\n").last.split(": ").last + '+08:00')
  link = article.css(".article_title_link").first.attributes["href"].value
  title = article.css(".article_title_link").first.text
  author = "Jeff Atwood"

  sleep(5)
  res = Net::HTTP.get_response(URI(link))
  if res.is_a?(Net::HTTPSuccess)
    post = Nokogiri::HTML.parse(res.body).css('.post-content').children
  else
    post = ''
  end

rss_item = <<-ITEM
<item>
<title>#{title}</title>
<link>#{link}</link>
<content>#{post}</content>
<pubDate>#{processed_published_date}</pubDate>
<guid>#{link}</guid>
</item>
ITEM

  puts rss_item
end
