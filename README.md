# convert html links to rss items

### fetch blog pagination pages by following previous/next page links

`export $(cat .env | xargs) && echo "[]" > ./out/pages.json && ruby ./bin/fetch_all.rb CoolshellPage https://coolshell.cn ./out/pages.json`
### fetch blog posts by following page links

`export $(cat .env | xargs) && echo "[]" > ./out/posts.json && ruby ./bin/fetch_all.rb CoolshellPost ./out/pages.json ./out/posts.json`

### generate rss feed

`export $(cat .env | xargs) && rm -f ./out/*.xml ./out/*.txt && ruby ./src/render.rb ./test/test_data/posts.json`