#!/bin/bash

export PAGE_BASE_URL=http://www.matrix67.com/blog
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log

echo "[]" > ./out/test_matrix67_posts.json

ruby ./bin/fetch_all.rb Matrix67Post ./test/test_data/matrix67_pages.json ./out/test_matrix67_posts.json