#!/bin/bash

export PAGE_BASE_URL=https://mindhacks.cn
export MAX_RETRY_COUNT=5
export LOG_FILE=./fetch.log
export DIRECTION=next

echo "[]" > ./out/test_mind_hacks_pages.json

ruby ./bin/fetch_all.rb MindHacksPage https://mindhacks.cn ./out/test_mind_hacks_pages.json