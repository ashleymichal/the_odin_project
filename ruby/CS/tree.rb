class Node
	attr_accessor :parent, :children
	def initialize(value)
		@value = value					# the value of this Node
		@parent = parent				# parent Node object
		@children = children		# array of other Node objects
	end
end

