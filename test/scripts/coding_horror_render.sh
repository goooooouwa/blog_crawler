#!/bin/bash

export BLOG_TITLE="Coding Horror"
export BLOG_DESCRIPTION="programming and human factors"
export BLOG_BASE_URL=https://blog.codinghorror.com
export SLICE=100
export REMOTE_BASE_URL=https://raw.githubusercontent.com/goooooouwa/out/master/coding_horror
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./src/render.rb ./test/test_data/coding_horror_posts.json
