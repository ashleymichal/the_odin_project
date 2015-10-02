leaving = 0
puts "ASK ME A QUESTION!"
while leaving < 3
  you = gets.chomp
  if you == "BYE"
    leaving += 1
    if leaving == 3
      puts "SURE GO ON YOU'VE STAYED YOUR HOUR"
      break
    end
    puts "NO, DON'T GO, STAY AND WATCH JEOPARDY WITH ME!"
  elsif you != you.upcase
    puts "HUH?! SPEAK UP, SONNY!"
    leaving = 0
  else
    year = rand(20) + 1930
    puts "NO, NOT SINCE " + year.to_s
    leaving = 0
  end
end