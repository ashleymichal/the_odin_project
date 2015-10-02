def grandfatherClock(&onTheHour)
  time = Time.now.hour
  if time % 12 == 0
    time = 12
  else
    time = time % 12
  end
  time.times do
    onTheHour.call
  end
end

grandfatherClock do
  puts 'CUCKOO!!'
end