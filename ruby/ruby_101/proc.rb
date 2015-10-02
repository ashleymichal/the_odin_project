#################
##  EXAMPLE 1  ##
#################

def doSelfImportantly someProc
  puts 'Everybody just HOLD ON!  I have something to do...'
  someProc.call
  puts 'OK everyone, I\'m done.  Go on with what you were doing.'
end

sayHello = Proc.new do
  puts 'hello'
end

sayGoodbye = Proc.new do
  puts 'goodbye'
end

# doSelfImportantly sayHello
# doSelfImportantly sayGoodbye

#################
##  EXAMPLE 2  ##
#################

def maybeDo someProc
  if rand(2) == 0
    someProc.call
  end
end

def twiceDo someProc
  someProc.call
  someProc.call
end

wink = Proc.new do
  puts '<wink>'
end

glance = Proc.new do
  puts '<glance>'
end

# maybeDo wink
# maybeDo glance
# twiceDo wink
# twiceDo glance

#################
##  EXAMPLE 3  ##
#################

def doUntilFalse firstInput, someProc
  input  = firstInput
  output = firstInput
  
  while output
    input  = output
    output = someProc.call input
  end
  
  input
end

buildArrayOfSquares = Proc.new do |array|
  lastNumber = array.last
  if lastNumber <= 0
    false
  else
    array.pop
    array.push lastNumber*lastNumber
    array.push lastNumber - 1
  end
end

alwaysFalse = Proc.new do |justIgnoreMe|
  false
end

# puts doUntilFalse([5], buildArrayOfSquares).inspect
# puts doUntilFalse('I\'m writing this at 3:00 am; someone knock me out!', alwaysFalse)

#################
##  EXAMPLE 4  ##
#################

def compose proc1, proc2
  Proc.new do |x|
    proc2.call(proc1.call(x))
  end
end

squareIt = Proc.new do |x|
  x * x
end

doubleIt = Proc.new do |x|
  x + x
end

doubleThenSquare = compose doubleIt, squareIt
squareThenDouble = compose squareIt, doubleIt

puts doubleThenSquare.call(5)
puts squareThenDouble.call(5)