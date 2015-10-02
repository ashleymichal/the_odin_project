puts "Enter a starting year"
starting_year = gets.chomp.to_i
puts "Enter an ending year"
ending_year = gets.chomp.to_i

puts "Here are all the leap years in between"

while starting_year != ending_year
  if starting_year % 4 == 0
    if starting_year % 100 != 0
      # it's a leap year
      puts starting_year
    else
      if starting_year % 400 == 0
        puts starting_year
      end
    end
  end
  # it's not a leap year
  starting_year += 1
end