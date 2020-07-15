/*
	Kth Multiple: Design an algorithm to find the kth number such that the only prime factors are 3,
	5, and 7. Note that 3, 5, and 7 do not have to be factors, but it should not have any other prime factors.
	For example, the first several multiples would be (in order) 1, 3, 5, 7, 9, 15, 21
*/

func kthMultiple(k: Int) {
	var arr: [Int] = [1, 3, 5, 7]
	let set: Set<Int> = [3, 5, 7]
	// Base cases without requiring calculation
	guard k > 4 else {
		if k < 0 {
			return
		}
		print(arr[0..<k])
		return
	}	
	
	var currentNum = 8
	outer: while arr.count < k {
		// no need to iterate over half the value since it won't be divisible
		for i in 2..<currentNum/2+1 {
			if currentNum % i == 0 {
				if isPrime(i) && !set.contains(i) {	// if it's prime and not 3, 5, 7, continue outer loop
					currentNum += 1
					continue outer
				}
			}
		}

		if kFactor(currentNum) {	// if it's divisible by 3, 5, or 7, then add it
			arr.append(currentNum)
		}
		currentNum += 1
	}

	print(arr)
}

func isPrime(_ num: Int) -> Bool {	// Determines if a number is prime
	let commonPrimes: Set<Int> = [2, 3, 5, 7]
	guard !commonPrimes.contains(num) else { return true }
	
	// no need to iterate over half the value since it won't be divisible
	for i in 2..<num/2 + 1 { 
		if num % i == 0 {
			return false
		}
	}
	return true
}

func kFactor(_ num: Int) -> Bool {
	let factors: [Int] = [3, 5, 7]
	for factor in factors {  
		if num % factor == 0 {
			return true
		}
	}
	return false
}

kthMultiple(k: 1)
kthMultiple(k: 4)
kthMultiple(k: 5)
kthMultiple(k: 7)
kthMultiple(k: 10)
kthMultiple(k: 25)