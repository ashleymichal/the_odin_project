class BinarySearchTree
	attr_accessor :root
	def build_tree data_set
		return nil if data_set.empty?
		current_node = Node.new(data_set.shift)
		puts "-----"
		puts "The current node is #{current_node.value}"
		# first iteration sets root
		if @root.nil?
			@root = current_node
			parent = nil
			puts "It is the root node"
		else
			# determine placement of new node in tree
			last_node = @root
			parent = nil
			while parent.nil?
				if current_node.value == last_node.value
					puts "This is a duplicate value"
					break
				elsif current_node.value < last_node.value
					if last_node.left_child.nil?
						last_node.left_child = current_node
						parent = last_node
						puts "This node's parent is #{parent.value}"
					else
						last_node = last_node.left_child
					end
				elsif current_node.value > last_node.value
					if last_node.right_child.nil?
						last_node.right_child = current_node
						parent = last_node
						puts "This node's parent is #{parent.value}"
					else
						last_node = last_node.right_child
					end
				end
			end
			current_node.parent = parent
		end
		return current_node if data_set.empty?
		build_tree(data_set)
	end
	# takes array, returns binary tree of Node objects
	# assumes data_set is sorted
	def build_tree_sorted data_set, parent=nil
		return nil if data_set.length == 0
		middle = data_set.length / 2
		current_node = Node.new(data_set[middle])
		@root = current_node if parent.nil?
		return current_node if data_set.length == 1
		current_node.parent = parent
		current_node.left_child=(build_tree_sorted(data_set[0...middle], current_node))
		current_node.right_child=(build_tree_sorted(data_set[middle+1..-1], current_node))
	end

	class Node
		attr_reader :value
		attr_accessor :parent, :left_child, :right_child

		def initialize value
			@value = value
		end
	end
end

# data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324].sort
# tree = BinarySearchTree.new
# tree.build_tree_sorted(data_set)
# puts tree.root.value

data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinarySearchTree.new
tree.build_tree(data_set)