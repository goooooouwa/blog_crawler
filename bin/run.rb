require "logger"
require "json"
require "pry-byebug"
require_relative "../src/page_fetcher"
require_relative "../src/post_fetcher"
require_relative "../src/renderer"
require_relative "../src/logging"
Dir[File.expand_path("../../blogs/*/*.rb", __FILE__)].each { |file| require file }

command = ARGV[0]
blog_name = ARGV[1]
custom_config = ARGV[2].nil? ? {} : JSON.parse(File.read(ARGV[2]))

global_config = JSON.parse(File.read(File.expand_path("../../src/config.json", __FILE__)))
blog_config = JSON.parse(File.read(File.expand_path("../../blogs/#{blog_name}/config.json", __FILE__)))

config = global_config.merge(blog_config).merge(custom_config)

Logging.logger = Logger.new(config["log_file"] || STDOUT)

def camel_case(string)
  string.capitalize.gsub(/_(\w)/) { $1.upcase }
end

case command
when "page"
  pa_fr = PageFetcher.new(Object.const_get("#{camel_case(blog_name)}Page"), config["pages_file"])
  pa_fr.max_retry_count = config["max_retry_count"]
  pa_fr.start(config["initial_page"], config["direction"])
when "post"
  po_fr = PostFetcher.new(Object.const_get("#{camel_case(blog_name)}Post"), config["posts_file"], config["pages_file"])
  po_fr.max_retry_count = config["max_retry_count"]
  po_fr.start
when "render"
  rdr = Renderer.new(config, config["remote_base_url"])
  rdr.posts_file = config["posts_file"]
  rdr.out_dir = config["out_dir"]
  rdr.slice = config["slice"]
  rdr.start
else
  "You gave me #{x} -- I have no idea what to do with that."
end
