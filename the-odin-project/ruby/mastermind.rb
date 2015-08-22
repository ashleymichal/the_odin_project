class Mastermind
  attr_accessor :guesses
  def initialize(player_name)
    @guesses = []
    @maximum_guesses = 12
    @codemaker = Player.new
    @secret_code = Code.new(true) # if codemaker is computer
    @codebreaker = Player.new(player_name, true)
  end
  
  def play
    # print instructions
    puts @secret_code.show
    begin
      # codebreaker makes a guess
      puts "You have #{@maximum_guesses - @guesses.length} guesses left."
      @guesses.each { |guess| puts guess.show }
      @guess = Code.new
      @guesses << @guess
    end until victory?(@guess.combo) || @guesses.length >= @maximum_guesses
    if victory?(@guess.combo)
      puts "You win!"
    else
      puts "You lose!"
    end
  end
  
  def victory?(guess)
    @secret_code.matches(guess) == [Code.code_length, 0]
  end
  
  class Player
    def initialize(name="Computer", human=false)
      @human = human
      @name = name
    end
  end
  
  class Code
    @@code_length = 4
    attr_reader :combo
    def initialize(random=false)
      unless random
        make_custom
      else
        make_random
      end
    end
    
    def show
      @combo.join(' ')
    end
    
    def self.code_length
      @@code_length
    end
    # takes a guess and returns an array with the number of bulls (@0) and cows (@1)
    def matches(guess)
      # first find bulls
      bulls = bulls(guess)
      remaining_guess = []
      guess.each_with_index do |letter, index|
        remaining_guess << letter unless bulls.include?(index)
      end
      remaining_combo = []
      @combo.each_with_index do |letter, index|
        remaining_combo << letter unless bulls.include?(index)
      end
      # then find cows
      cows = cows(remaining_guess, remaining_combo)
      return [bulls.length, cows]
    end
  
    private
    def make_random
      @combo = []
      @@code_length.times do
        @combo << rand(65..70).chr #random letter between A and F
      end
    end
    
    def make_custom
      begin
        puts "Enter your secret code."
        @combo = cleanup(gets)
      rescue
        puts $!
        retry
      end
    end
    
    def cleanup(combo)
      combo = combo.gsub(/\s+/, '')
      combo = combo.upcase
      combo = combo.split('')
      raise "Combo must be #{@@code_length} letters long" unless combo.length == @@code_length
      unless combo.all? { |letter| ("A".."F").include?(letter) }
        raise "Combo must contain only letters A-F"
      end
      combo
    end
    
    # takes an array (Code.combo)
    # returns an array of indexes corresponding to "bulls"
    def bulls(guess)
      bulls = []
      guess.each.with_index do |letter, index|
        bulls << index if letter == @combo[index]
      end
      bulls
    end
    
    # takes an array (Code.combo)
    # returns an integer representing the number of "cows"
    def cows(guess, combo)
      cows = 0
      guess.each { |letter| cows += 1 if combo.include?(letter) }
      cows
    end
  end
end

## Tests

# secret_code = Mastermind::Code.new
# p secret_code.combo
# random_code = Mastermind::Code.new(true) #random
# p random_code.combo
#
# p random_code.matches(secret_code.combo)

puts "Enter your name"
player_name = gets.chomp
new_game = Mastermind.new(player_name)
new_game.play


=begin NOTES

GAMEPLAY
  2 players - a CODEMAKER and a CODEBREAKER
  the CODEMAKER chooses a pattern of 4 CODEPEGS  <= to start this is the computer
    duplicates are allowed
    order matters
  the CODEBREAKER tries to guess the pattern within TWELVE TURNS
    GUESSES are made by placing row of CODEPEGS on the board

1.  *computer picks a combination*, not shown [ E D A D ]
2.  *user picks a combination*, [ A B C D ]
3.  display all combo guesses, plus @'s for correct placement and *'s for correct letter
    ex.   [ A B C D ] @ *
4.  repeat steps 2 and 3 until there are twelve guesses or the right combo is found


step 1.  create Code class with initializer <== done

step 2.  build random code generator (also part of Code class)

step 3.  design the matching function(s)
  - match exact placement and symbol
  - match remaining matches that aren't placed right

step 4.  build players

step 5.  build gameplay

Classes:
  CodeMaker   - Chooses combination of pegs (starts as computer player)
  CodeBreaker - Tries to guess combinations (always human player)
  Code        - Combination of 4 letters between A-F
              - Can match itself against other codes

=end

