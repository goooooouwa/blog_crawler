#!/bin/bash

export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log

cp ./test/test_data/matrix67_posts.json ./out/test_matrix67_posts.json

ruby ./bin/fetch_all.rb Matrix67Post ./test/test_data/matrix67_pages.json ./out/test_matrix67_posts.json