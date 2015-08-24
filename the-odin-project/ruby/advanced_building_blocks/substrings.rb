def substrings(phrase, words)
  phrase = phrase.downcase
  frequencies = Hash.new(0)
  words.each do |word|
    working_phrase = phrase
    while working_phrase.length > 0
      break if !working_phrase.include?(word)
      frequencies[word.to_sym] += 1
      new_start = working_phrase.index(word) + word.length
      working_phrase = working_phrase[new_start..-1]
    end
  end
  frequencies
end

# TEST
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)