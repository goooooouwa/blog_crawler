require_relative '../src/page_objects/mind_hacks_page'
require_relative '../src/page_objects/mind_hacks_post'
require_relative '../src/page_objects/matrix67_page'
require_relative '../src/page_objects/matrix67_post'
require_relative '../src/page_objects/coding_horror_post'
require_relative '../src/page_objects/coding_horror_page'

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
else
  "You gave me #{x} -- I have no idea what to do with that."
end
