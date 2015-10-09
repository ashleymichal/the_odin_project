def merge_sort(list1, list2 = [])
	# list2 is only invoked once you have broken down to single-value arrays
	if list2.empty?
		return list1 if list1.length == 1

		# break the list in half and recall the method
		half = list1.length/2
		list2 = list1[half..-1]
		list1 = list1[0...half]
		return merge_sort(merge_sort(list1), merge_sort(list2))
	else
		# you have a second, sorted list
		sorted = []
		while list1.length > 0 && list2.length > 0
			smaller = (list1.first < list2.first) ? list1.shift : list2.shift
			sorted << smaller
		end
		# if one of the lists is empty, the remainder of the other list is appended
		sorted + list1 + list2
	end
end

list = [108, 15, 50, 4, 8, 42, 23, 16]

p merge_sort(list)