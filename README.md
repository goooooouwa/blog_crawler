# htmlparser

htmlparser is a little ruby script that can turn your favourite blog into RSS feed. Combined with [blog2kindle](https://github.com/goooooouwa/blog2kindle), you can turn the RSS feed into an ebook to read on your ebook reader, such as Kindle, Apple Books.

## Demo: ebook of the [Coding Horror](https://blog.codinghorror.com/) blog

![Screen Shot 2021-11-25 at 6 48 48 PM](https://user-images.githubusercontent.com/1495607/143427976-0fa33f81-93e6-4271-8562-53cce35bd1e1.png)

![Screen Shot 2021-11-25 at 6 49 02 PM](https://user-images.githubusercontent.com/1495607/143427994-5eea1a37-2b73-4c71-9858-eed10ea09abd.png)

## Prerequesite

1. create the Page object and Post object for the blog you want to extract content from
2. setup [blog2kindle](https://github.com/goooooouwa/blog2kindle) to generate ebooks

## Example: turn Coding Horror blog into an ebook

### 1. Create page and post objects

Coding Horror page object:

```ruby
class CodingHorrorPage < Page
  def initialize(page_link, page_html)
    @page_link = page_link
    @page_link = page_html.at("meta[property='og:url']")['content']
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = ENV["BLOG_BASE_URL"] + next_page_link_node.attributes["href"].value unless next_page_link_node.nil?
    @previous_page_link = ENV["BLOG_BASE_URL"] + previous_page_link_node.attributes["href"].value unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end

  def to_json(_)
    {
      page_link: @page_link,
      previous_page_link: @previous_page_link,
      next_page_link: @next_page_link,
      post_links: [@page_link]
    }.to_json
  end
end
```

Coding Horror post object:

```ruby
class CodingHorrorPost < Post
  def initialize(post_link, post_html)
    @page_link = post_link
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end

  def to_json(_)
    {
      page_link: @page_link,
      title: @title,
      published_date: @published_date,
      content: @content,
      author: @author
    }.to_json
  end
end
```

### 2. Fetch all pages of the Coding Horror blog

```bash
ruby ./bin/fetch_all.rb CodingHorrorPage https://blog.codinghorror.com/building-a-pc-part-ix-downsizing/ ./out/coding_horror_pages.json
```

### 3. Fetch all posts of the Coding Horror blog

```bash
ruby ./bin/fetch_all.rb CodingHorrorPost ./out/coding_horror_pages.json ./out/coding_horror_posts.json
```

### 4. Generate the RSS feed

```bash
ruby ./src/render.rb ./out/coding_horror_posts.json   # will generate an xml RSS file
```

### 5. Publish the RSS feed

Publish the RSS feed to a Github repo:

```bash
git add ./out/rss.xml
git commit -m "publish blog feeds"
git push origin master   # publish the RSS file somewhere online to get an public link
```

### 6. generate the ebook

```bash
# in blog2kindle
echo "https://raw.githubusercontent.com/goooooouwa/out/master/out/rss.xml" > config/feeds.txt
python3 src/news2kindle.py
```

Now you will have your favourite blog sent to your Kindle, waiting for you to pick up.
