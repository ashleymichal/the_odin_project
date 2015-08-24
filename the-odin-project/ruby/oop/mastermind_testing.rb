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
        combo.shift
      end
    end
  end
end

15.times do
  secret = Code.new
  puts "The secret code is:"
  p secret.show
  guess = Guess.new(secret)
  puts "The guess is:"
  p guess.show
  puts "The number of bulls is:"
  p guess.bulls.length
  puts "The number of cows is"
  p guess.cows
end