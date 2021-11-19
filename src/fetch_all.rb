require_relative './mind_hacks_page'
require_relative './mind_hacks_post'
require_relative './coding_horror_post'
require_relative './coding_horror_page'

case ARGV[0]
when "CodingHorrorPage"
  CodingHorrorPage.start ARGV[1]
when "CodingHorrorPost"
  CodingHorrorPost.start
when "MindHacksPage"
  MindHacksPage.start ARGV[1]
when "MindHacksPost"
  MindHacksPost.start
else
  "You gave me #{x} -- I have no idea what to do with that."
end
