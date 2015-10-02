puts "Type in a word.  Any word.  To end, press ENTER on an empty line"
line = ""
store = []
while line != "\n"
  line = gets
  store.push(line.chomp)
end

puts store.sort