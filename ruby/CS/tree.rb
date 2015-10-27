class BinarySearchTree
	attr_reader :data_set, :root
	def initialize data_set
		@data_set = data_set
		@root = Node.new(data_set[0])
	end

	# takes an array of data and turns it into a binary tree full of Node objects
	def build_tree
		data_set[1..-1].each { |value| place(Node.new(value)) }
	end

	# finds the best available space in the tree
	def place node
		parent = root
		loop do
			return nil if node == parent
			next_step = node > parent ? parent.right : parent.left
			break if next_step.nil?
			parent = next_step
		end
		set_parent_child(parent, node)
	end

	# sets the parent/child relationships for two nodes
	def set_parent_child parent, child
		parent > child ? (parent.left = child) : (parent.right = child)
		child.parent = parent
	end

	class Node
		attr_reader :value
		attr_accessor :left, :right, :parent

		def initialize value
			@value = value
		end

		def > node
			value > node.value
		end

		def < node
			value < node.value
		end

		def == node
			value == node.value
		end
	end
end


if __FILE__ == $0
  data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]#.sort
	tree = BinarySearchTree.new data_set
	puts tree.build_tree
	puts tree.root.value
end

	# takes an array of data and turns it into a binary tree full of Node objects
	# assumes data_set is sorted
	# def build_tree_sorted data_set, parent=nil
	# 	return nil if data_set.length == 0
	# 	middle = data_set.length / 2
	# 	current_node = Node.new(data_set[middle], parent)
	# 	@root = current_node if parent.nil?
	# 	return current_node if data_set.length == 1
	# 	current_node.left=(build_tree_sorted(data_set[0...middle], current_node))
	# 	current_node.right=(build_tree_sorted(data_set[middle+1..-1], current_node))
	# end