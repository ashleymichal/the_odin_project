# Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
#       1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
# By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

def fibonacci number
  sequence = []
  a = 1
  b = 1
  while true
    sequence << b
    newa = b
    b = a+b
    a = newa
    break if b > number
  end
  sequence
end

def even_fib number
  fibonacci(number).select {|i| i%2 == 0}
end

def add(*numbers)
  numbers.inject(0) { |sum, number| sum + number }
end

puts add(*even_fib(4000000))