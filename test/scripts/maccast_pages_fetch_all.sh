#!/bin/bash

export BLOG_BASE_URL=https://www.maccast.com/category/podcast
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log
export DIRECTION=next

ruby ./bin/fetch_all.rb MaccastPage $BLOG_BASE_URL ./out/maccast_pages.json
