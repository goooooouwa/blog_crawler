Dir["./src/blogs/*/*.rb"].each {|file| require file }

klass = Object.const_get(ARGV[0])
klass.start(ARGV[1], ARGV[2])