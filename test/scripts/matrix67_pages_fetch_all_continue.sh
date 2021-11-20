#!/bin/bash

export PAGE_BASE_URL=http://www.matrix67.com/blog
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log
export DIRECTION=next

cp ./test/test_data/matrix67_pages.json ./out/test_matrix67_pages.json

ruby ./bin/fetch_all.rb Matrix67Page http://www.matrix67.com/blog/page/1 ./out/test_matrix67_pages.json