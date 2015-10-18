class BinarySearchTree
	attr_reader :root

	# takes an array of data and turns it into a binary tree full of Node objects
	# assumes data_set is sorted
	def self.build_tree data_set, parent=nil
		# puts "-----"
		case data_set.length
		when 0
			return nil
		when 1
			# puts "Data set is 1 element"
			return nil if data_set[0] == parent.value || data_set[0] == parent.parent.value
			# puts "New node created: #{data_set[0]}"
			return Node.new(data_set[0], parent)
		else
			middle = data_set.length / 2
			# puts "Data set is #{data_set.length} elements"
			# puts "The center element is #{data_set[middle]}"
			current_node = Node.new(data_set[middle], parent)
			# puts "New node created: #{current_node.value}"
			@root = current_node if parent.nil?
			current_node.left_child=(build_tree(data_set[0...middle], current_node))
			current_node.right_child=(build_tree(data_set[middle+1..-1], current_node))
		end
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

data_set = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
BinarySearchTree.build_tree(data_set)