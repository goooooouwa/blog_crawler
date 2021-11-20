#!/bin/bash

export BLOG_BASE_URL=https://coolshell.cn
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log
export DIRECTION=next

echo "[]" > ./out/test_coolshell_pages.json

ruby ./bin/fetch_all.rb CoolshellPage https://coolshell.cn ./out/test_coolshell_pages.json