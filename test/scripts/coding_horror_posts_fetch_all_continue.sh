#!/bin/bash

export PAGE_BASE_URL=https://blog.codinghorror.com
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log

cp ./test/test_data/coding_horror_posts.json ./out/test_coding_horror_posts.json

ruby ./bin/fetch_all.rb CodingHorrorPost ./test/test_data/coding_horror_pages.json ./out/test_coding_horror_posts.json