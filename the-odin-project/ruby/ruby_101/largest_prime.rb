# The prime factors of 13195 are 5, 7, 13, and 29
# What is the largest prime factor of the number 600851475143?

def is_factor multiple, factor
  multiple % factor == 0
end

def list_factors number
  factors = []
  (1..number).each do |factor|
    break if factors.include?(factor)
    factors << factor << (number/factor) if is_factor(number, factor)
  end
  factors.sort.uniq
end

def is_prime number
  list_factors(number).length <= 2
end

def list_prime_factors number
  list_factors(number).select { |i| is_prime(i) }
end

def largest_prime_factor number
  list_prime_factors(number).max
end

puts "The largest prime factor of 600851475143 is :#{largest_prime_factor(600851475143)}"