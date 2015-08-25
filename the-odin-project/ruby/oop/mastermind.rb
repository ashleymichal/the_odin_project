class Mastermind
  def initialize
    @guesses = []
    @maximum_guesses = 12
    # Ask player if they want to be codemaker or codebreaker
    build_players
    # Codemaker picks secret code
    @secret_code = @codemaker.code
  end
  
  def build_players
    print "What is your name?: "
    player_name = gets.chomp
    begin
      puts "Do you want to be the Codemaker or the Codebreaker?"
      player = gets.chomp
      if player.downcase == "codemaker"
        @codemaker   = Player.new(player_name)
        @codebreaker = Player.new
      elsif player.downcase == "codebreaker"
        @codemaker   = Player.new
        @codebreaker = Player.new(player_name)
      else
        raise "Please answer either codebreaker or codemaker"
      end
    rescue
      puts $!
      retry
    end
  end
  
  def play
    # print instructions
    begin
      # codebreaker makes a guess
      puts "You have #{@maximum_guesses - @guesses.length} guesses left."
      puts "+---------+--------+"
      @guesses.each do |guess| 
        puts guess.show
        puts "+---------+--------+"
      end
      @guess = @codebreaker.guess(@secret_code)
      @guesses << @guess
    end until victory? || @guesses.length >= @maximum_guesses
    if victory?
      puts "#{@codebreaker.name} wins!"
    else
      puts "#{@codemaker.name} wins!"
    end
  end
  
  private
  def victory?
    @guess.combo == @secret_code.combo
  end
  
  class Player
    attr_reader :name
    def initialize(name='The computer')
      @name  = name
      @human = @name != 'The computer'
    end
    def guess(secret_code)
      if @human
        guess = gets.chomp
        Guess.new(secret_code, guess)
      else
        Guess.new(secret_code)
      end
    end
    def code
      if @human
        print "Please enter a secret code:  "
        code = gets.chomp
        Code.new(code)
      else
        Code.new
      end
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
    def show
      matches = ""
      @bulls.length.times { matches << "+ " }
      @cows.times { matches << "- " }
      "| " + super + " | " + matches
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
end

new_game = Mastermind.new
new_game.play