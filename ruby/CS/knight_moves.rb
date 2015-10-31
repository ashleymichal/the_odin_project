class Board
	attr_reader :spaces
	def initialize
		@spaces = []
		build_board		# an array of all possible spaces
	end

	def build_board
		8.times do |x|
			8.times do |y|
				@spaces << Space.new([x, y])
			end
		end
	end
end

class Space
	attr_reader :x, :y
	def initialize coordinates
		@x = coordinates[0]
		@y = coordinates[1]
	end
end

class Knight
	attr_accessor :start, :finish, :moves
	def initialize start, finish, moves = []
		@start = Space.new(start)
		@finish = Space.new(finish)
		@moves = moves << @start
	end
end

def knight_moves start, finish
	board = Board.new
	knight = Knight.new(start, finish)
	start if start == finish
end

if __FILE__ == $0
	p knight_moves [0,0], [0,0]
end