#!/bin/bash

export BLOG_TITLE="刘未鹏 | Mind Hacks"
export BLOG_DESCRIPTION="思维改变生活"
export BLOG_BASE_URL=https://mindhacks.cn
export SLICE=100
export REMOTE_BASE_URL=https://raw.githubusercontent.com/goooooouwa/out/master/mind_hacks
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./src/render.rb ./test/test_data/mind_hacks_posts.json
