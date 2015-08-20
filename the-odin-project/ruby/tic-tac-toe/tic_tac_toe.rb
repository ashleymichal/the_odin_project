class TicTacToe
  @@winning_combinations = [
    [:A1, :A2, :A3], [:B1, :B2, :B3], [:C1, :C2, :C3],
    [:A1, :B1, :C1], [:A2, :B2, :C2], [:A3, :B3, :C3],
    [:A1, :B2, :C3], [:A3, :B2, :C1]
  ] # array of arrays
  def initialize
    # initialize 2 players, assign player1 to X and player2 to O
    @player1 = Player.new
    @player2 = Player.new
    # initialize board
    @board = Board.new
    @spaces = []
    build_spaces
  end
  
  class Player
    attr_reader :mark
    # there can only be 2 players...
    @@number_of_players = 0
    @@max_number_of_players = 2
    # later can implement ability to name players, not yet though
    def initialize
      unless @@number_of_players >= @@max_number_of_players
        @mark = @@number_of_players == 0 ? :X : :O 
        @@number_of_players += 1
      else
        puts "There can only be 2 players" # this should actually throw an exception and ask again... ought to be a more elegant way to handle this.
      end
    end
    def self.number_of_players
      @@number_of_players
    end
    def mark
      @mark
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
  
  def build_spaces
    space_names = [ :A1, :A2, :A3, :B1, :B2, :B3, :C1, :C2, :C3 ]
    space_names.each do |position|  
      @spaces << Space.new(position)
    end
  end
  
  def place_mark(position, mark)
    # TODO
    # should take player input which is the position of the Space object, also player mark
    space = find_space_by_position(position)
    space.mark=(mark)
  end
  
  def find_space_by_position(position)
    @spaces.detect { |space| space.position == position.to_sym }
  end
  
  def find_spaces_by_mark(mark)
    @spaces.select { |space| space.mark == mark.to_sym }
  end
  
  def display
    @spaces.each do |space|
      puts space.display
    end
  end
  
  def play
    # until board is full
    #   show board
    #   ask for player input (should be in the form of "RC" i.e. "B2", be sure to capitalize and chomp)
    #   update board
    #   check for winning combination, return winner if applicable
    #   switch player
    # cats-game
  end

  def victory(player_spaces)
    # create "winning combinations" array of Boards
    # must be able to match either "X"'s or "O"'s but not " "'s
    @@winning_combinations.include?(player_spaces)
  end
end
