#!/bin/bash

export SLICE=100
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./src/render.rb ./test/test_data/matrix67_posts.json
