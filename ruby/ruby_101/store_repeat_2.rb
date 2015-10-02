#  Write the program we talked about at the very beginning of this chapter.
# Hint: There's a lovely array method which will give you a sorted version of an array: sort. Use it!
puts "Type in a word.  Any word.  To end, press ENTER on an empty line"
line = ""
store = []
while line != "\n"
  line = gets
  store.push(line.chomp)
end

puts store.sort

# Try writing the above program without using the sort method. A large part of programming is solving problems, so get all the practice you can!
puts "Type in a word.  Any word.  To end, press ENTER on an empty line"
line = ""
store = []
while line != "\n"
  line = gets
  store.push(line.chomp)
end

# now sort store alphabetically
