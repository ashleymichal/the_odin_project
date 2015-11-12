require 'enumerable'

describe Enumerable do

	describe '#my_each' do

		it 'takes a block and iterates over each item in the collection' do
			expect do
				[1,2,3,4].my_each { |a| print a }
			end.to output('1234').to_stdout
		end

	end

	describe '#my_each_with_index' do

		it 'takes the block with its index' do
			expect do
				[1,2,3,4].my_each_with_index { |a, i| print "#{i}#{a}" }
			end.to output('01122334').to_stdout
		end

	end
	
	describe '#my_select' do

		it 'returns an array with only elements that match the block' do
			expect([1,2,3,4].my_select { |a| a % 2 == 0 }).to eq([2,4])
		end

	end
	
	describe '#my_count' do

		it 'returns the # of items in the collection that match the block' do
			expect([1,2,3,4].my_count { |a| a % 2 == 0 }).to eq(2)
		end

	end
	
	describe '#my_map' do

		it 'applies block to elements of a collection and returns a new array' do
			expect([1,2,3,4].my_map { |a| a * 2 }).to eq([2,4,6,8])
		end
	end
	
	describe '#my_inject' do

		it 'sums the elements of the array' do
			expect([1,2,3,4].my_inject { |total, a| total + a }).to eq(10)
		end

		it 'sums the elements of the array with a starting value' do
			expect([1,2,3,4].my_inject(1) { |total, a| total + a }).to eq(11)
		end
		
	end
end