#!/bin/bash

export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log

echo "[]" > ./out/test_matrix67_posts.json

ruby ./bin/fetch_all.rb Matrix67Post