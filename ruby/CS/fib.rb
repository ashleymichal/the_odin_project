# iterative solution
def fibs(n)
	sequence = []
	a = 0
	b = 1
	n.times do |num|
		sequence << a
		a, b = b, (a + b)
	end
	sequence
end

# recursive solution, returns int not sequence
def fibs_rec(n)
	n < 2 ? n : (fibs_rec(n-1) + fibs_rec(n-2))
end

# recursive solution which returns sequence using above solution.
# because wrapper method
def fibs_seq(n, sequence = [])
	return sequence if n == 0

	sequence.unshift(fibs_rec(n))
	return fibs_seq(n-1, sequence)
end