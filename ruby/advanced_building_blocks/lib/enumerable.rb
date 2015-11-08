module Enumerable
  def my_each
    index = 0
    while index < self.length
      yield(self[index])
      index += 1
    end
    self
  end
  
  def my_each_with_index
    index = 0
    while index < self.length
      yield(self[index], index)
      index += 1
    end
    self
  end
  
  def my_select
    new_array = []
    self.my_each do |item|
      new_array << item if yield(item)
    end
    new_array
  end
  
  def my_all?
    self.my_each do |item|
      unless yield(item)
        return false
      end
    end
    true
  end
  
  def my_any?
    self.my_each do |item|
      if yield(item)
        return true
      end
    end
    false
  end
  
  def my_none?(&block)
    return true unless self.my_any?(&block)
  end
  
  def my_count(&block)
    matches = []
    self.my_each do |item|
      if !block_given? || yield(item)
        matches << item
      end
    end
    matches.size
  end
  
  def my_map
    new_array = []
    self.my_each do |item|
      new_array << yield(item)
    end
    new_array
  end
  
  def my_inject
    # first we need to determine the type of items in array
    self.my_each do |item|
      yield(new_thing,item)
    end
    new_thing
  end
end

def multiple_els(array)
  array.my_inject { |total, element| total * element }
end