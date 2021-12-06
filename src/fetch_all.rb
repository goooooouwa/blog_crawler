require_relative './config'
Dir[File.join(File.dirname(__FILE__), "./blogs/*/*.rb")].each {|file| require file }

klass = Object.const_get(ARGV[0])
klass.start
