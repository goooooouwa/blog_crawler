require 'json'

module Config
  attr_accessor :config

  @@config = JSON.parse(File.read(File.join(File.dirname(__FILE__), '../config.json')))

  def self.config
    @@config
  end
end
