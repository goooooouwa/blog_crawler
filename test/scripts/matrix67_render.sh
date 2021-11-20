#!/bin/bash

export BLOG_TITLE="Matrix67: The Aha Moments"
export BLOG_DESCRIPTION=""
export BLOG_BASE_URL=http://www.matrix67.com/blog
export SLICE=100
export REMOTE_BASE_URL=https://raw.githubusercontent.com/goooooouwa/out/master/matrix67
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./src/render.rb ./test/test_data/matrix67_posts.json
