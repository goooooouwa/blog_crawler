require 'json'
require 'date'

class Renderer
  def initialize(blog)
    @blog = blog
  end

  def start(posts_file=File.join(File.dirname(__FILE__), '../out/posts.json'))
    posts = JSON.parse(File.read(posts_file))

    posts.sort_by { |hs| hs['published_date'] }.each_slice(ENV['SLICE'].to_i).with_index do |slice, index|
      rss_content = ''
      slice.each do |post|
        rss_content.concat(render_rss_item_with_no_image(post))
      end
      rss_slice_feed = render_rss_header(@blog) + rss_content + render_rss_footer
      File.open("#{ENV['OUT_DIR']}/feeds.txt", 'a') { |file| file.write("#{@blog['remote_base_url']}/slice-#{index}.xml\n") }
      File.open("#{ENV['OUT_DIR']}/slice-#{index}.xml", 'w') { |file| file.write(rss_slice_feed) }
    end
  end

  def render_rss_footer
    <<-FOOTER
</channel>
</rss>
    FOOTER
  end

  def render_rss_header(blog)
    <<-HEADER
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>#{blog[:title]}</title>
<description>#{blog[:description]}</description>
<link>#{blog[:base_url]}</link>
<pubDate>#{blog[:published_date]}</pubDate>
<!-- other elements omitted from this example -->
    HEADER
  end

  def render_rss_item_with_no_image(rss_item)
    <<-ITEM
<item>
<title><![CDATA[ #{rss_item['title']} ]]></title>
<link>#{rss_item['page_link']}</link>
<content><![CDATA[ #{rss_item['content'].gsub(/<img([\w\W]+?)[\/]?>/, '<img alt="image placeholder" >')} ]]></content>
<pubDate>#{rss_item['published_date']}</pubDate>
<guid>#{rss_item['page_link']}</guid>
<author><![CDATA[ #{rss_item['author']} ]]></author>
</item>
    ITEM
  end
end
