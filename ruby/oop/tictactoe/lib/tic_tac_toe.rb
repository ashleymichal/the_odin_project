class TicTacToe
  SPACES = [ :A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3 ]
  @@winning_combinations = [
    [:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3],
    [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3],
    [:A1, :B2, :C3], [:A3, :B2, :C1]
  ]
  attr_reader :players, :active_player, :board
  def initialize
    # initialize 2 players, assign playerX to X and playerO to O
    player = Struct.new(:mark)
    @players = [player.new(:X), player.new(:O)]
    @active_player = @players[0]
    @board = Hash.new()
    SPACES.each { |space| @board[space] = ' ' }
    start
  end
  
  def place_mark(mark, space)
    @board[space] = mark
  end
  
  def find_spaces_by_mark(mark)
    spaces = @board.keys.select { |space| @board[space] == mark }
  end
  
  def board_full?
    @board.values.none? { |space| space == ' ' }
  end
  
  def show_board
    puts "  1    2    3"
    puts "---------------"
    row = "A".ord
    @board.keys.each do |space|
      print "[ #{@board[space]} ]"
      if space.to_s.include?("3")
        puts "  #{row.chr}"
        puts "---------------"
        row += 1
      end
    end
  end

  def select_space
    begin
      space = gets.chomp("Pick a space")
      parse(space.strip)
    rescue
      puts "That doesn't appear to be a valid space"
      retry
    end
  end

  def parse(space)
    parsed_space = space.upcase.split('').sort { |a, b| b <=> a }.join.to_sym
    raise ArgumentError unless (SPACES.include?(parsed_space) && @board[parsed_space] == ' ')
    parsed_space
  end

  def game_over(winner)
    message = winner ? "#{winner.mark} wins!" : "Cat's game"
    puts message
  end

  def victory?(player)
    @@winning_combinations.any? { |combo| combo - find_spaces_by_mark(player.mark) == [] }
  end
    
  def start
    until board_full?
      puts "Welcome to Tic Tac Toe!"
      puts "It's #{@active_player.mark}'s turn!"
      show_board
      place_mark(@active_player.mark, select_space)
      return game_over(@active_player) if victory?(@active_player)
      @active_player = @players.find { |p| p != @active_player}
    end
    game_over(nil)
  end
end

if __FILE__ == $0
  while true
    new_game = TicTacToe.new
    puts "would you like to play again? (Y/N)"
    again = gets.chomp
    break unless again.match(/y/i)
  end
end