class OrangeTree
  def initialize
    @age = 0
    @height = 5 # in feet
    @oranges = 0
  end
  
  def countTheOranges
    puts "There are " + @oranges.to_s + " oranges on the tree."
  end
  
  def pickAnOrange
    if @oranges == 0
      puts "There are no more oranges left this year"
    else
      @oranges -= 1
      puts "That orange was delicious!"
    end
  end

  def oneYearPasses
    @oranges = 0
    @age += 1
    @height += 1
    if @age > 3
      @oranges = 10 + @age*2
    end
    puts "the tree is now " + @age.to_s + " years old."
    if @age > 10
      puts "the tree has died"
      exit
    end
  end
end

tree = OrangeTree.new
tree.oneYearPasses
tree.countTheOranges
tree.oneYearPasses
tree.oneYearPasses
tree.countTheOranges
tree.oneYearPasses
tree.pickAnOrange
tree.pickAnOrange
tree.countTheOranges
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses
tree.oneYearPasses