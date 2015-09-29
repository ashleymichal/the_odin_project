class GameFile
  def initialize(filename)
    
  end
  
  def save
  
  end

  def load
  
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

class Hangman
  attr_reader :count, :dictionary, :secret_word, :guess_log
  def initialize(word)
    @count = 12
    @guess_log = GuessLog.new
    @secret_word = SecretWord.new(word.downcase, @guess_log.guesses)

    play
  end

  def play
    until count == 0
      @guess_log.remaining_guesses(@count)
      puts "TESTING: #{@secret_word.word}"
      puts "#{@secret_word.masked_word}"
        # check if the word is complete, if yes player wins
      puts @guess_log.guesses.join(' ')
      input = get_player_input
      if input == 'save' 
        puts 'save game'
        next
      else
        player_guess(input)
        @count -= 1 if @secret_word.guess_in_word?(input)
      end
    end
    puts 'count reduced to 0. you lose.'
  end

  def player_guess(input)
    @guess_log.guesses=(input)
    @secret_word.masked_word=(@guess_log.guesses)
  end

  def get_player_input
    begin
      puts "Enter a letter, or the word 'save' if you want to save your game"
      input = validate_player_input(gets.chomp.downcase)
    rescue
      puts $!
      retry
    end
  end

  def validate_player_input(input)
    # input must either be the word 'save' or a single alphabet character
    raise "Invalid entry." unless input == 'save' || /^[a-z]{1}$/ =~ input
    return input
  end

  class GuessLog
    attr_reader :guesses
    def initialize
      @guesses = []
    end

    def guesses=(guess)
      @guesses << guess
    end
  
    def already_guessed?(guess)
      @guesses.include?(guess)
    end

    def remaining_guesses(count)
      puts "You have #{count} guesses left."
    end
  end

  class SecretWord
    attr_reader :word, :masked_word
    def initialize(word, guesses)
      @word = word.split('')
      @masked_word = []
      masked_word=(guesses)
    end
    
    def masked_word
      @masked_word.join(' ')
    end

    def masked_word=(guesses)
      @masked_word = []
      @word.each do |letter|
        @masked_word << (guesses.include?(letter) ? letter : '_')
      end
    end
  
    def guess_in_word?(guess)
      @word.include?(guess)
    end
  
    def complete?
      @masked_word == @word
    end
  end

end

## TESTS
# load dictionary, filter to words between 5-12 chars long
min_length = 5
max_length = 12
dictionary_filename = "5desk.txt"

dictionary = Dictionary.new(5, 12, dictionary_filename)
new_game = Hangman.new(dictionary.random)
# puts "Loading dictionary"
# puts "Dictionary contains #{new_game.dictionary.wordlist.length} words."
#
# # randomly select a word
# secret_word = new_game.secret_word
# puts "Here is a random word: #{secret_word.word}"
#
# # display count for remaining incorrect guesses
# count = new_game.count
# puts "You have #{count} incorrect guesses left."
#
# # Take player guess
# new_game.get_player_input
# guesses = new_game.guess_log.guesses
# puts "all guesses: #{guesses.join(' ')}"
#
# # Evaluate guess right-ness
#
# # display word guesses
# puts "Here is the random word displayed #{secret_word.masked_word=(guesses)}"
#
# ## GAMEPLAY
# # Ask player to load_game or start new_game