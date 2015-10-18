class BinarySearchTree
	attr_accessor :root
	# takes an array of data and turns it into a binary tree full of Node objects
	# assumes data_set is sorted
	def build_tree data_set, parent=nil
		return nil if data_set.length == 0
		middle = data_set.length / 2
		current_node = Node.new(data_set[middle], parent)
		@root = current_node if parent.nil?
		return current_node if data_set.length == 1
		current_node.left_child=(build_tree(data_set[0...middle], current_node))
		current_node.right_child=(build_tree(data_set[middle+1..-1], current_node))
	end

	class Node
		attr_reader :value, :parent
		attr_accessor :left_child, :right_child

		def initialize value, parent
			@value = value
			@parent = parent
		end
	end
end

data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort
tree = BinarySearchTree.new
tree.build_tree(data_set)
puts tree.root.value