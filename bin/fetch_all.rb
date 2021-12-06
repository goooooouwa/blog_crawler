require 'pry-byebug'
require 'dotenv/load'

require File.expand_path("../../src/config", __FILE__)
Dir[File.join(File.dirname(__FILE__), "../src/blogs/*/*.rb")].each {|file| require file }

Config.blog=(ARGV[1]) unless ARGV[1].nil?

klass = Object.const_get(ARGV[0])
klass.start(Config.blog)
