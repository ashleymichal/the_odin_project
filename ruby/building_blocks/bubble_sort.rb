def bubble_sort(array)
  array.length.times do
    array.each_with_index do |a, index|
      b = array[index+1]
      array[index], array[index+1] = b, a if b && a > b
    end
  end
  array
end

p bubble_sort([4,3,78,2,0,2])


def bubble_sort_by(array, &block)
  # array.length.times do
    array.each_with_index do |a, index|
      b = array[index+1]
      if b && yield(a, b) > 0
        array[index], array[index+1] = b, a
      end
    end
end

a = bubble_sort_by(["hi","hello","hey"]) do |left,right|
   left.length - right.length
 end
 
p a