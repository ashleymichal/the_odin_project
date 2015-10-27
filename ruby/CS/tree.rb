class BinarySearchTree
	attr_accessor :root
	def initialize
		@root = nil
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

	# takes an array of data and turns it into a binary tree full of Node objects
	def build_tree data_set
		root = Node.new(data_set[0])
		data_set[1..-1].each do |value|
			node = Node.new(value)
			parent = find_parent(node)
			node.parent = parent
			node.value < parent.value ? parent.left_child = node : parent.right_child = node
		end
	end

	def find_parent working_node
		# child = nil
		begin
			parent = child.nil? ? root : child
			child = parent.value > working_node.value ? parent.left : parent.right
		end until child.nil?
		parent
	end

	class Node
		attr_reader :value
		attr_accessor :left, :right, :parent

		def initialize value
			@value = value
		end
	end
end


if __FILE__ == $0
  data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]#.sort
	# tree_sorted = BinarySearchTree.new
	# puts tree_sorted.build_tree_sorted(data_set)
	# puts tree_sorted.root.value
	tree = BinarySearchTree.new
	puts tree.build_tree(data_set)
	puts tree.root.value

end
