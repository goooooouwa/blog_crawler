require 'pry-byebug'
require 'dotenv/load'

require File.expand_path("../../src/renderer", __FILE__)
require File.expand_path("../../src/config", __FILE__)

Renderer.new(Config.blog).start