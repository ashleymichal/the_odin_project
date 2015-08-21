class Mastermind
  

  
end

class Code
  attr_reader :combo
  # takes a string (combo) of 4 letters A..F
  def initialize(random=false)
    unless random
      begin
        puts "Enter your secret code."
        puts "Remember, secret codes must be 4 letters between A and F."
        @combo = validate(gets)
      rescue # another opportunity to play with different exceptions
        puts "Code not valid, try again."
        retry
      end
    else
      @combo = random
    end
  end
  
  # def random
  #   @combo = []
  #   4.times do
  #     @combo << #random letter between A and F
  #   end
  # end

  # check that all characters in combo are between A and F, and that combo is 4 long
  def validate(combo)
    combo.gsub!(/\s+/, '')
    combo.upcase!
    combo.split('')
  end
end

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

step 2.  design the matching function(s)
  - match exact placement and symbol
  - match remaining matches that aren't placed right

step 3.  build random code generator (also part of Code class)

step 4.  build players

step 5.  build gameplay

Classes:
  CodeMaker   - Chooses combination of pegs (starts as computer player)
  CodeBreaker - Tries to guess combinations (always human player)
  Code        - Combination of 4 letters between A-F
              - Can match itself against other codes

=end

secret_code = Code.new
p secret_code.combo