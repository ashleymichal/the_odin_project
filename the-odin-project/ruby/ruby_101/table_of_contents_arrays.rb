lineWidth = 50
puts "Table of Contents".center lineWidth

contents = [["Numbers", 1],["Letters", 72],["Variables", 118]]

contents.each_with_index do |chapter, i|
  title = "Chapter " + i.to_s + ": " + chapter[0]
  page  = "page " + chapter[1].to_s
  puts title.ljust(lineWidth/2) + page.rjust(lineWidth/2)
end