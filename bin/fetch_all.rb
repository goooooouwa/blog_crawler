require_relative '../src/page_objects/mind_hacks_page'
require_relative '../src/page_objects/mind_hacks_post'
require_relative '../src/page_objects/matrix67_page'
require_relative '../src/page_objects/matrix67_post'
require_relative '../src/page_objects/coding_horror_post'
require_relative '../src/page_objects/coding_horror_page'
require_relative '../src/page_objects/coolshell_page'
require_relative '../src/page_objects/coolshell_post'
Dir["./src/blogs/*/*.rb"].each {|file| require file }

case ARGV[0]
when "CodingHorrorPage"
  CodingHorrorPage.start(ARGV[1], ARGV[2])
when "CodingHorrorPost"
  CodingHorrorPost.start(ARGV[1], ARGV[2])
when "MindHacksPage"
  MindHacksPage.start(ARGV[1], ARGV[2])
when "MindHacksPost"
  MindHacksPost.start(ARGV[1], ARGV[2])
when "Matrix67Page"
  Matrix67Page.start(ARGV[1], ARGV[2])
when "Matrix67Post"
  Matrix67Post.start(ARGV[1], ARGV[2])
when "CoolshellPage"
  CoolshellPage.start(ARGV[1], ARGV[2])
when "CoolshellPost"
  CoolshellPost.start(ARGV[1], ARGV[2])
when "MaccastPage"
  MaccastPage.start(ARGV[1], ARGV[2])
else
  "You gave me #{ARGV[0]} -- I have no idea what to do with that."
end
