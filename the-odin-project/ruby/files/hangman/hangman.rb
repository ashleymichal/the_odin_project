class Dictionary
  attr_reader :wordlist
  def initialize(min_length, max_length, filename)
    @wordlist = filter(min_length, max_length, load(filename))
  end
  
  def load(filename)
    dictionary = File.readlines(filename)
    dictionary.each do |word|
      word.strip!
    end
    dictionary
  end
  
  def filter(min_length, max_length, dictionary)
    dictionary.select { |word| word.length.between?(min_length, max_length) }
  end
  
  def random
    @wordlist[rand(0...@wordlist.length)]
  end
end

def remaining_guesses(count)
  puts "You have #{count} guesses left."
end

class SecretWord
  def initialize(word)
    @word = word
    @guesses = []
  end

  def display
    
  end
  
end

## TESTS
# load dictionary, filter to words between 5-12 chars long
min_length = 5
max_length = 12
dictionary_filename = "5desk.txt"

puts "Loading dictionary"
dictionary = Dictionary.new(min_length, max_length, dictionary_filename)
puts "Dictionary contains #{dictionary.wordlist.length} words."

# randomly select a word
random_word = dictionary.random
puts "Here is a random word: #{random_word}"

# display count for remaining incorrect guesses
count = 12
remaining_guesses(count)

# display word guesses
