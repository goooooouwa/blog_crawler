#!/bin/bash

export SLICE=100
export OUT_DIR=./out

rm -f ./out/*.xml ./out/*.txt

ruby ./bin/render.rb
