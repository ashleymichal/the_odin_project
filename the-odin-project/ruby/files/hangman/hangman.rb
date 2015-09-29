class Hangman
  attr_reader :count, :dictionary, :secret_word, :guess_log
  def initialize(dictionary_filename)
    @count = 12
    @dictionary = Dictionary.new(5, 12, dictionary_filename)
    @secret_word = SecretWord.new(@dictionary.random)
    @guess_log = GuessLog.new(@secret_word.word)
  end
  
  def get_player_input
    begin
      puts "Enter a letter, or the word 'save' if you want to save your game"
      validate_player_input(gets.chomp.downcase)
    rescue
      puts $!
      retry
    end
  end
  
  def validate_player_input(input)
    # input must either be the word 'save' or a single alphabet character
    if input == 'save'
      puts "save game"
    elsif input.match(/[a-z]/) && input.length == 1
      @guess_log.guesses=(input)
      @count -= 1 if @guess_log.guess_in_word?(input)
    else
      raise "Invalid entry."
    end
  end
  
  class GuessLog
    attr_reader :guesses
    def initialize(secret_word)
      @guesses = []
      @secret_word = secret_word
    end
  
    def guesses=(guess)
      @guesses << guess
    end
    
    def guess_in_word?(guess)
      @secret_word.include?(guess)
    end
    
    def already_guessed?(guess)
      @guesses.include?(guess)
    end

    def remaining_guesses(count)
      puts "You have #{@guesses.length} guesses left."
    end
  end

  class SecretWord
    attr_reader :word
    def initialize(word)
      @word = word.split('')
    end

    def display(guesses)
      masked_word = []
      @word.each do |letter|
        masked_word << (guesses.include?(letter) ? letter : '_')
      end
      masked_word.join(' ')
    end
  end

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
end

## TESTS
# load dictionary, filter to words between 5-12 chars long
min_length = 5
max_length = 12
dictionary_filename = "5desk.txt"

new_game = Hangman.new(dictionary_filename)
puts "Loading dictionary"
puts "Dictionary contains #{new_game.dictionary.wordlist.length} words."

# randomly select a word
secret_word = new_game.secret_word
puts "Here is a random word: #{secret_word.word}"

# display count for remaining incorrect guesses
count = new_game.count
puts "You have #{count} incorrect guesses left."

# Take player guess
new_game.get_player_input
guesses = new_game.guess_log.guesses
puts "all guesses: #{guesses.join(' ')}"

# Evaluate guess right-ness

# display word guesses
puts "Here is the random word displayed #{secret_word.display(guesses)}"
