class Mastermind
  attr_accessor :guesses
  def initialize
    # @guesses = []
    # @maximum_guesses = 12
    @secret_code = Code.new
    @guess = Guess.new(@secret_code)
  end
  
  def test
    puts "=========="
    p @secret_code.show
    p @guess.show
    puts "Bulls: #{@guess.bulls.length}"
    puts "Cows:  #{@guess.cows}"
    puts "=========="
  end
  
  def play
    # print instructions
    puts @secret_code.show
    begin
      # codebreaker makes a guess
      puts "You have #{@maximum_guesses - @guesses.length} guesses left."
      @guesses.each { |guess| puts guess.show }
      input = gets.chomp
      @guess = Code.new(input)
      @guesses << @guess
    end until victory?(@guess) || @guesses.length >= @maximum_guesses
    if victory?(@guess)
      puts "You win!"
    else
      puts "You lose!"
    end
  end
  
  class Code
    attr_reader :combo, :length
    def initialize(code="random")
      @length = 4
      unless code=="random"
        build(code)
      else
        @combo = []
        @length.times do
          @combo << rand(65..70).chr #random letter between A and F
        end
      end
    end
    def show
      @combo.join(' ')
    end

    private
    def build(input)
      begin
        @combo = input ? cleanup(input) : cleanup(gets)
      rescue
        puts $!
        input = nil
        retry
      end
    end
    def cleanup(combo)
       combo = combo.gsub(/\s+/, '')
       combo = combo.upcase
       combo = combo.split('')
       raise "Combo must be 4 letters long" unless combo.length == 4
       unless combo.all? { |letter| ("A".."F").include?(letter) }
         raise "Combo must contain only letters A-F"
       end
       combo
    end
  end

  class Guess < Code
    attr_reader :bulls, :cows
    def initialize(to_match, code="random")
      @bulls = []
      @cows = 0
      @to_match = to_match.combo
      super(code)
      matches(@to_match)
    end
    def matches(to_match)
      # first find bulls
      find_bulls(to_match)
      remaining_guess = []
      @combo.each.with_index do |letter, index|
        remaining_guess << letter unless @bulls.include?(index)
      end
      remaining_code = []
      to_match.each.with_index do |letter, index|
        remaining_code << letter unless @bulls.include?(index)
      end
      # then find cows
      find_cows(remaining_guess.sort, remaining_code.sort)
    end
  
    private
    def find_bulls(to_match)
      to_match.each.with_index do |letter, index|
        @bulls << index if letter == @combo[index]
      end
    end
    def find_cows(guess, combo)
      guess.each do |letter|
        if combo.include?(letter)
          @cows += 1
          combo = combo.drop_while { |i| i <= letter }
        end
      end
    end
  end
  
  private
  def victory?(guess)
    @guess.combo == @secret_code.combo
  end 
  class Player
    def initialize(name="Computer", human=false)
      @human = human
      @name = name
    end
  end
end

8.times do
  new_game = Mastermind.new
  new_game.test
end