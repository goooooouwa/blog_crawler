# convert html links to rss items

## run in local

### fetch blog posts by following previous/next post links

`ruby ./src/fetch_next.rb`

### generate rss feed

`$ export $(cat .env | xargs) && rm -f out/* && ruby ./src/render.rb`
