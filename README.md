# Read your favourite blog on your Kindle

htmlparser is a little ruby script that can turn your favourite blog into RSS feed. Combined with [blog2kindle](https://github.com/goooooouwa/blog2kindle), you can turn any blog into an ebook to read on your ebook reader, such as Kindle, Apple Books.

## Demo: ebook of the [Coding Horror](https://blog.codinghorror.com/) blog

![Screen Shot 2021-11-25 at 6 48 48 PM](https://user-images.githubusercontent.com/1495607/143427976-0fa33f81-93e6-4271-8562-53cce35bd1e1.png)

![Screen Shot 2021-11-25 at 6 49 02 PM](https://user-images.githubusercontent.com/1495607/143427994-5eea1a37-2b73-4c71-9858-eed10ea09abd.png)

## Prerequesite

- [blog2kindle](https://github.com/goooooouwa/blog2kindle)

## Example: turn Coding Horror blog into an ebook

### 1. Create page and post objects along with `config.json`

Coding Horror page and post object:

```ruby
# src/blogs/coding_horror/coding_horror_page.rb
class CodingHorrorPage < Page
  def initialize(page_link, page_html)
    super(page_link, page_html)
    next_page_link_node = page_html.css(".left .read-next-title a").first
    previous_page_link_node = page_html.css(".right .read-next-title a").first
    @next_page_link = "https://blog.codinghorror.com#{ next_page_link_node.attributes["href"].value }" unless next_page_link_node.nil?
    @previous_page_link = "https://blog.codinghorror.com#{ previous_page_link_node.attributes["href"].value }" unless previous_page_link_node.nil?
    @post_links = [@page_link]
  end
end

# src/blogs/coding_horror/coding_horror_posts.rb
class CodingHorrorPost < Post
  def initialize(post_link, post_html)
    super(post_link, post_html)
    @title = post_html.css(".post-title").text
    @published_date = post_html.at("meta[property='article:published_time']")['content']
    @content = post_html.css(".post-content").children
    @author = "Jeff Atwood"
  end
end
```

Config file:

```json
// src/blogs/coding_horror/config.json
{
    "title": "Coding Horror",
    "description": "programming and human factors",
    "homepage": "https://blog.codinghorror.com",
    "direction": "previous",
    "remote_base_url": "https://raw.githubusercontent.com/goooooouwa/out/master/coding_horror",
    "initial_page": "https://blog.codinghorror.com/building-a-pc-part-ix-downsizing/"
}
```

### 2. Fetch all pages of the Coding Horror blog

```bash
ruby ./bin/run.rb page coding_horror
```

### 3. Fetch all posts of the Coding Horror blog

```bash
ruby ./bin/run.rb post coding_horror
```

### 4. Generate the RSS feed

```bash
ruby ./bin/run.rb render coding_horror   # generate RSS file in config["our_dir"]
```

### 5. Publish the RSS feed

For example, you can publish the RSS feed to a Github repo:

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
