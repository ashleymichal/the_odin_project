// The prime factors of 13195 are 5, 7, 13, and 29
// What is the largest prime factor of the number 600851475143?

var isFactor = function(num1, num2) {
	return num1 % num2 === 0;
}

var contains = function(list, obj) {
	var k = list.length;
	while (k--) {
		if (list[k] === obj) {
			return true;
		}
	}
	return false;
}

var listFactors = function(multiple) {
	var factors = [];
	for (i = 1; i < multiple/2+1; i++) {
		if (contains(factors, i)) {
			break;
		}
		if (isFactor(multiple, i)) {
			factors.push(i);
			if (!contains(factors, multiple/i)) {
				factors.push(multiple/i);
			}
		}
	}
	return factors;
}

var isPrime = function(number) {
	var factors = listFactors(number);
	return factors.length <= 2;
}

var listPrimeFactors = function(integer) {
	var factors = listFactors(integer);
	var primes = [];
	for (j = 0; j < factors.length; j++) {
		if (isPrime(factors[j])) {
			primes.push(factors[j])
			continue;
		}
	}
	return primes;
}

var largestPrimeFactor = function(int) {
	var primeFactors = listPrimeFactors(int);
	return primeFactors.pop();
}

largestPrimeFactor(600851475143);