require "logger"
require "json"
require "pry-byebug"
require_relative "../src/list_page_fetcher"
require_relative "../src/post_fetcher"
require_relative "../src/renderer"
require_relative "../src/logging"
Dir[File.expand_path("../../src/blogs/*/*.rb", __FILE__)].each { |file| require file }

global_config = JSON.parse(File.read(File.expand_path("../../src/config.json", __FILE__)))
blog_config = JSON.parse(File.read(File.expand_path("../../src/blogs/#{ARGV[1]}/config.json", __FILE__)))
custom_config = ARGV[2].nil? ? {} : JSON.parse(File.read(ARGV[2]))

config = global_config.merge(blog_config).merge(custom_config)

Logging.logger = Logger.new(config["log_file"] || STDOUT)

def camel_case(string)
  string.capitalize.gsub(/_(\w)/) { $1.upcase }
end

case ARGV[0]
when "page"
  ListPageFetcher.new(Object.const_get("#{camel_case(ARGV[1])}ListPage"), config["pages_file"], config["base_url"], config["max_retry_count"]).start(config["initial_page"], config["direction"])
when "post"
  PostFetcher.new(Object.const_get("#{camel_case(ARGV[1])}Post"), config["posts_file"], config["pages_file"], config["max_retry_count"]).start
when "render"
  Renderer.new(config["posts_file"], config, config["out_dir"], config["remote_base_url"], config["slice"]).start
else
  "You gave me #{x} -- I have no idea what to do with that."
end
