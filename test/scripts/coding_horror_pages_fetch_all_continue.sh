#!/bin/bash

export BLOG_BASE_URL=https://blog.codinghorror.com
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log
export DIRECTION=previous

cp ./test/test_data/coding_horror_pages.json ./out/test_coding_horror_pages.json

ruby ./bin/fetch_all.rb CodingHorrorPage https://blog.codinghorror.com/building-a-pc-part-ix-downsizing/ ./out/test_coding_horror_pages.json