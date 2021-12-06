require 'json'

module Config

  @@blog = JSON.parse(File.read(ENV['BLOG_CONFIG']))

  def self.blog
    @@blog
  end

  def self.blog=(blog_config)
    @@blog = JSON.parse(File.read(blog_config))
  end

  def self.reload!
    @@blog = JSON.parse(File.read(ENV['BLOG_CONFIG']))
  end
end
