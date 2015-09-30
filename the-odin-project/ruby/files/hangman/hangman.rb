require 'yaml'

class Hangman
  attr_reader :count, :dictionary, :secret_word, :guess_log
  def initialize(word, guess_log=GuessLog.new, count=12)
    @count = count
    @guess_log = guess_log
    @secret_word = SecretWord.new(word.downcase)
    play
  end
  
  private
  def play
    puts 'You may save or quit anytime by entering the word "save" or "quit"'
    until count == 0
      @guess_log.remaining_guesses(@count)
      puts "TESTING: #{@secret_word.word}"
      @secret_word.masked_word=(@guess_log.guesses)
      puts "#{@secret_word.masked_word}"
      break if @secret_word.complete?
      puts @guess_log.guesses.join(' ')
      input = get_player_input
      case input
      when 'quit'
        exit
      when 'save' 
        gamefile = GameFile.new
        gamefile.save(@secret_word.word.join, @guess_log, @count)
        next
      else
        player_guess(input)
        @count -= 1 unless @secret_word.guess_in_word?(input)
      end
    end
    if @secret_word.complete?
      puts "You win!"
    else
      puts "Out of turns."
    end
  end

  def player_guess(input)
    @guess_log.guesses=(input)
    @secret_word.masked_word=(@guess_log.guesses)
  end

  def get_player_input
    begin
      input = validate_player_input(gets.chomp.downcase)
    rescue
      puts $!
      retry
    end
  end

  def validate_player_input(input)
    # input must either be the word 'save' or a single alphabet character
    raise "Invalid entry." unless input == 'save' || input == 'quit' || /^[a-z]{1}$/ =~ input
    raise "You already guessed that letter" if @guess_log.already_guessed?(input)
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
    def initialize(word)
      @word = word.split('')
      @masked_word = []
    end

    def masked_word=(guesses)
      @masked_word = []
      @word.each do |letter|
        @masked_word << (guesses.include?(letter) ? letter : '_')
      end
    end
    
    def masked_word
      @masked_word.join(' ')
    end
  
    def guess_in_word?(guess)
      @word.include?(guess)
    end
  
    def complete?
      @masked_word == @word
    end
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

class GameFile
  def initialize(filename='gamefile.yaml')
    @filename = filename
  end

  def save(secret_word, guess_log, count)
    yaml = YAML::dump({:secret_word => secret_word, :guess_log => guess_log, :count => count})
    File.open(@filename, 'w') do |file|
      file.write(yaml)
    end
  end

  def load
    game_file = open(@filename, 'r')
    yaml = game_file.read
    YAML::load(yaml)
  end
end

def new_game
  # Load Dictionary from File
  min_length = 5
  max_length = 12
  dictionary_filename = "5desk.txt"
  dictionary = Dictionary.new(5, 12, dictionary_filename)
  game_file = GameFile.new
  begin
    puts "Would you like to start a NEW game or LOAD your last game?"
    game = gets.chomp.upcase
    case game
    when 'LOAD'
      yaml = game_file.load
      new_game = Hangman.new(yaml[:secret_word], yaml[:guess_log], yaml[:count])
    when 'NEW'
      new_game = Hangman.new(dictionary.random)
    else
      raise 'Please respond with either LOAD or NEW'
    end
  rescue
    puts $!
    retry
  end
end

new_game


## TODO
# 1. get gamefile information from gamefile directory
# 2. ask player to choose gamefile or start new game
# => assert maximum of 3 gamefiles in directory
# 3. load gamefile
# 4. At start of turn, give option to save new gamefile