class TicTacToe
  def initialize
    # initialize 2 players, assign player1 to X and player2 to O
    @player1 = Player.new
    @player2 = Player.new
    # initialize board
    @board = Board.new
  end
  def play
    # until board is full
    #   show board
    #   ask for player input (should be in the form of "RC" i.e. "B2", be sure to capitalize and chomp)
    #   update board
    #   check for winning combination (full row, full column, diagonal)
    #   switch player
    # cats-game
  end
end
class Player
  # there can only be 2 players...
  @@number_of_players = 0
  @@max_number_of_players = 2
  # later can implement ability to name players, not yet though
  def initialize
    unless @@number_of_players >= @@max_number_of_players
      @mark = @@number_of_players == 0 ? :X : :O 
      @@number_of_players += 1
    else
      puts "There can only be 2 players" # this should actually throw an exception and fail the build...
    end
  end
  def place_mark(space)
    # should take player input which is the position of the Space object
    # then find_space_by_position(position.to_sym)
    # then do the below
    space.mark=(@mark)
  end
  def self.number_of_players
    @@number_of_players
  end
  def mark
    @mark
  end
end

class Board
  @@winning_combinations = [
    [:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3],
    [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3],
    [:A1, :B2, :C3], [:A3, :B2, :C1]
  ] # array of arrays
  def initialize
    @spaces = [ :A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3 ]
    # create 9 Space objects and push to @spaces, poss use loop in loop
    @spaces.each_with_index do |space, index|
      @spaces[index] = Space.new(space)
    end
  end
  def display
    @spaces.each_with_index do |space, index|
      print "#{space.display}, #{space.position}"
    end
  end
  def find_space_by_position(position)
    # TODO
  end
  def find_spaces_by_mark(mark)
    # TODO
  end
  def victory(player_spaces)
    # create "winning combinations" array of Boards
    # must be able to match either "X"'s or "O"'s but not " "'s
    @@winning_combinations.include?(player_spaces)
  end
end

class Space
  @@default_mark = " "
  def initialize(position)
    @position = position
    @mark = @@default_mark
  end
  def mark=(new_mark)
    # lock mark if it has changed
    if @mark == @@default_mark
      @mark = new_mark
    else
      puts "That space is already filled"
    end
  end
  def display
    "[ #{mark} ]"
  end
  def position
    @position
  end
  def mark
    @mark
  end
end

# TESTING Space class
A1 = Space.new("A1")
# TESTING Player class
player1 = Player.new
player2 = Player.new
p Player.number_of_players
p player1.mark
p player2.mark
# TESTING Player class calling Space class
A1.mark=(player1.mark)
p A1.display
A1.mark=(player2.mark)
p A1.display
# TESTING Build and display Board
board = Board.new
board.display