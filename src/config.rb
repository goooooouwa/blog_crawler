require 'json'

module Config
  def self.blog
    JSON.parse(File.read(ENV['BLOG_CONFIG']))
  end
end
