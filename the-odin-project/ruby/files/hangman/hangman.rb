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

require 'set'

class Hangman
  attr_reader :secret_word, :player, :remaining_guesses
  def initialize
    @dictionary = load_dictionary("5desk.txt", 5, 12)
    @secret_word = Word.new(@dictionary)
    print "Enter player name: "
    name = gets.chomp.capitalize
    @player = Player.new(name)
    @remaining_guesses = 12
  end
  
  def play
    until @remaining_guesses == 0
      puts "Remaining turns: #{@remaining_guesses}"
      puts "Your guesses: #{@player.guesses.join(' ')}"
      puts
      puts @secret_word.show
      puts "TESTING ONLY: secret word is #{secret_word.word}"
      begin
        print "Enter a new guess: "
        guess = gets.chomp[0]
        @player.new_guess(guess)
      rescue
        puts $!
        retry
      end
      good_guess = @secret_word.update_masked_word(@player.guesses)
      if @secret_word.word == @secret_word.masked_word
        puts "You win!"
        return
      end
      @remaining_guesses -= 1 unless good_guess
    end
    puts "You ran out of guesses!"
    return
  end
  
  private
  def load_dictionary(dictionary_file, min_length, max_length)
    dictionary = File.readlines(dictionary_file)
    dictionary.each do |word|
      word.strip!
    end
    dictionary.select { |word| word.length.between?(min_length,max_length) }
  end
end

class Player
  attr_reader :name, :guesses
  def initialize(name)
    @name = name
    @guesses =[]
  end

  # returns 'nil' if guess is already in the set
  def new_guess(guess)
    unless @guesses.include?(guess)
      @guesses << guess.upcase
    else
      raise "You already guessed that letter"
    end
  end
end

class Word
  attr_reader :word, :masked_word
  def initialize(dictionary)
    @word = random(dictionary).upcase.split('')
    @masked_word = []
    update_masked_word
  end
  
  def update_masked_word(guesses=[])
    old = @masked_word
    @masked_word = []
    @word.each do |letter|
      guesses.include?(letter) ? @masked_word << letter : @masked_word <<  '_'
    end
    return old != @masked_word
  end
  
  def show
    @masked_word.join(' ')
  end
  
  private
  def random(dictionary)
    dictionary[rand(0...dictionary.length)]
  end
end

new_game = Hangman.new
new_game.play