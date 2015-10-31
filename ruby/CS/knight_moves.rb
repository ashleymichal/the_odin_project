class Board
	attr_reader :spaces
	def initialize
		@spaces = []
		build_board		# an array of all possible spaces
	end

	def build_board
		8.times do |x|
			8.times do |y|
				@spaces << [x, y]
			end
		end
	end
end

# class Space
# 	attr_reader :x, :y
# 	def initialize coordinates
# 		@x = coordinates[0]
# 		@y = coordinates[1]
# 	end
# end

class Knight
	@@MOVES = [ [ 1,2], [ 1,-2],
							[-1,2], [-1,-2],
							[ 2,1], [ 2,-1],
							[-2,1], [-2,-1] ]

	attr_reader :position, :path
	def initialize position, path = []
		@position = position
		@path = path + [position]
	end

	# def position
	# 	[@position.x, @position.y]
	# end

	def possible_moves
		moves = []
		@@MOVES.each do |move|
			moves << [position,move].transpose.map {|x| x.reduce(:+)}
		end
		moves.select { |position| $board.spaces.include?(position) }
	end
end

$board = Board.new

def knight_moves start, finish
	queue = []
	knight = Knight.new(start)
	loop {
		break if knight.path.last == finish
		knight.possible_moves.each do |move|
			queue << Knight.new(move, knight.path)
		end
		knight = queue.shift
	}
	knight.path
end

if __FILE__ == $0
	start = [0,0]
	finish = [5,4]
	p knight_moves(start, finish)
end