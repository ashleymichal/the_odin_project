class BinarySearchTree
	attr_reader :root
	attr_accessor :last_node

	def initialize
		@root = nil
	end

	class Node
		attr_reader :value#, :child_nodes
		attr_accessor :parent, :child_nodes
		def initialize(value, parent_node=nil, child_nodes=nil)
			@value = value								# the value of this Node
			@parent_node = parent_node		# parent Node object
			@child_nodes = child_nodes		# array of other Node objects
		end

		# def child_nodes=(child_node)
		# 	case child_node.value
		# 	when < @value
		# 		@child_nodes[:left] = child_node
		# 	when > @value
		# 		@child_nodes[:right] = child_node
		# 	end
		# end
	end

	def build_tree(array)
		# turn array into binary tree full of Node objects
		@root = Node.new(array.shift)
		@last_node = @root
		array.each do |element|
			next_node = Node.new(element, @last_node)
			@last_node.child_nodes=(next_node)
			@last_node = next_node
		end
	end
end

new_tree = BinarySearchTree.new
array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort
new_tree.build_tree(array)

current_node = new_tree.root
puts current_node.value
until current_node.child_nodes.nil?
	puts current_node.child_nodes.value
	current_node = current_node.child_nodes
end