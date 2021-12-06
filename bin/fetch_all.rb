require 'pry-byebug'
require 'dotenv/load'

require File.expand_path("../../src/config", __FILE__)
Dir[File.join(File.dirname(__FILE__), "../src/blogs/*/*.rb")].each {|file| require file }

klass = Object.const_get(ARGV[0])
klass.start
