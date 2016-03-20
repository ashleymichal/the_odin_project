class TicTacToe
  @@space_names = [ :A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3 ]
  @@winning_combinations = [
    [:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3],
    [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3],
    [:A1, :B2, :C3], [:A3, :B2, :C1]
  ]
  def initialize
    # initialize 2 players, assign playerX to X and playerO to O
    player = Struct.new(:mark)
    @playerX = player.new('X')
    @playerO = player.new('O')
    # initialize board
    @spaces = []
    construct_board
  end
  
  def construct_board
    @@space_names.each do |position|  
      @spaces << Space.new(position)
    end
  end
  
  def place_mark(mark, space)
    space.mark=(mark)
  end
  
  def find_space_by_position(position)
    @spaces.detect { |space| space.position == position.to_sym }
  end
  
  def find_spaces_by_mark(mark)
    marked_spaces = @spaces.select { |space| space.mark == mark.to_sym }
    marked_spaces.map do |space|
      space.position
    end
  end
  
  def board_full?
    @spaces.none? { |space| space.mark == " " }
  end
  
  def show_board
    puts "  1    2    3"
    puts "---------------"
    row = "A".ord
    @spaces.each do |space|
      print "[ #{space.mark} ]"
      if space.position.to_s.include?("3")
        puts "  #{row.chr}"
        puts "---------------"
        row += 1
      end
    end
  end
  
  def start
    active_player = @playerX
      until board_full?
        show_board
        puts "#{active_player.mark}'s turn"
        place_mark(active_player.mark)
        if victory?(active_player)
          puts "#{active_player.mark}'s win!"
          return
        end
        active_player == @playerX ? active_player = @playerO : active_player = @playerX
      end
      show_board
      puts "Cats game, no one wins."
      # cats-game if the board fills without a winnder
  end

  def victory?(player)
    @@winning_combinations.any? { |combo| combo - find_spaces_by_mark(player.mark) == [] }
  end
end

if __FILE__ == $0
  new_game = TicTacToe.new
  new_game.start
end