# Your Task
#
# You will be building a simple command line Hangman game where one player plays against the computer, but a bit more advanced. If you're unfamiliar with how Hangman works, see Wikipedia.
#
# [ X ] Download the 5desk.txt dictionary file from http://scrapmaker.com/.
# [ X ] When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.
# [ X ] You don't need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses she has before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.
# [ X ] Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.
# [   ] Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects... you can serialize your game class too!
# [   ] When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!

class Hangman
  attr_reader :secret_word
  attr_accessor :remaining_guesses, :guesses
  def initialize
    @dictionary = Dictionary.new("5desk.txt")
    @secret_word = Word.new(@dictionary)
    @guesses = []
    @remaining_guesses = 12
  end
  
  def game
    # give option to load gamefile
    # repeat turns until game is over
    until game_over
      turn
    end
  end
  
  def game_over
    @remaining_guesses == 0
  end
  
  def victory
    @secret_word.masked_word == @secret_word.word
  end
  
  def turn
    display_status
    input = get_player_input
    # if input == 'save'    # TODO coerce...
    #   # TODO get filename from player(?) AND/OR make default filename
    #   gamefile = Gamefile.new(filename)
    #   gamefile.save
    # else
    new_guess = Guess.new(input)
    @guesses << new_guess
    @secret_word.masked_word=(@guesses)
    # end
  end
  
  def display_status
    puts "You have #{@remaining_guesses} guesses remaining"
    puts "Already guessed:    #{@guesses}"
    puts "Secret word so far: #{@secret_word.masked_word}"
  end
  
  def get_player_input
    # TODO
    # - validate input
  end

  class Word
    attr_reader :masked_word
    def initialize(dictionary)
      @word = dictionary.random
      @masked_word = []
    end
  
    ## try implementing with .gsub or similar
    def masked_word=(guesses=[])
      ## each letter .gsub('_') if not in guesses
    end
    
    def word
      @word.upcase.split('')
    end
  end
  
  class Guess
    def initialize(input)
    end
    
    def str #(?)
    end
  end

  ## TODO build GameFile class methods
  class GameFile
    def initialize(filename)
      @filename = filename
      ## set directory; class variable?
    end
    
    def save
      ## save game to file
      
    end
  
    def load
      ## load game from file
    end
  end
  
  class Dictionary
    def initialize(dictionary_file)
      MIN_LENGTH = 5
      MAX_LENGTH = 12
      @dictionary = load(dictionary_file, MIN_LENGTH, MAX_LENGTH)
    end
    
    def choose_random
      dictionary[rand(0...dictionary.length)]
    end
    
    private
    def load(filename, min_length, max_length)
      dictionary = File.readlines(dictionary_file)
      dictionary.each do |word|
        word.strip!
      end
      dictionary.select { |word| word.length.between?(min_length,max_length) }
    end
  end 
  
end