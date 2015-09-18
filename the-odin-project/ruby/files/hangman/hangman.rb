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

# display count of remaining guesses
# display current state of secret_word
# player makes a guess
  # show if guess was correct or incorrect
  # if there are no remaining guesses, the player loses

class Hangman
  attr_reader :secret_word, :player, :remaining_guesses
  def initialize
    @dictionary = Dictionary.new("5desk.txt", 5, 12)
    @secret_word = Word.new(@dictionary)
    @remaining_guesses = 12
  end
  
  class Dictionary
    def initialize(dictionary_file, min_length, max_length)
      dictionary = File.readlines(dictionary_file)
      dictionary.each do |word|
        word.strip!
      end
      @dictionary = dictionary.select { |word| word.length.between?(min_length,max_length) }
    end
  end 

  class Word
    attr_reader :word, :masked_word
    def initialize(dictionary)
      @word = random(dictionary).upcase.split('')
      @masked_word = []
      update_masked_word
    end
  
    ## try implementing with .gsub or similar
    def masked_word=(guesses=[])
      ## each letter .gsub('_') if not in guesses
    end
  
    def masked_word
      
    end
  
    private
    def random(dictionary)
      dictionary[rand(0...dictionary.length)]
    end
  end
end

new_game = Hangman.new
new_game.play