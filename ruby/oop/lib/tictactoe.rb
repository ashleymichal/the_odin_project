class TicTacToe
end

class Player
	@@number_of_players = 0
	attr_reader :mark

	def initialize
		@mark = @@number_of_players == 0 ? :X : :O
		@@number_of_players += 1
	end
end

class Board
	def initialize
		@spaces = build_board
	end

	def show
		puts "    1   2   3"
		[:A, :B, :C].each do |row|
			puts "#{row.to_s}  | #{@spaces[row].join(" | ")} |"
		end
	end

	def build_board
		Hash.new([' ', ' ', ' '])
	end
end