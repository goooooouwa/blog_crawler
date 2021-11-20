#!/bin/bash

export PAGE_BASE_URL=https://mindhacks.cn
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log

echo "[]" > ./out/test_mind_hacks_posts.json

ruby ./bin/fetch_all.rb MindHacksPost ./test/test_data/mind_hacks_pages.json ./out/test_mind_hacks_posts.json