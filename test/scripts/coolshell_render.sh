#!/bin/bash

export BLOG_TITLE="酷 壳 – CoolShell"
export BLOG_DESCRIPTION="享受编程和技术所带来的快乐 – Coding Your Ambition"
export BLOG_BASE_URL=https://coolshell.cn
export SLICE=100
export REMOTE_BASE_URL=https://raw.githubusercontent.com/goooooouwa/out/master/coolshell
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./src/render.rb ./test/test_data/coolshell_posts.json
