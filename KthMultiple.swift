/*
	Kth Multiple: Design an algorithm to find the kth number such that the only prime factors are 3,
	5, and 7. Note that 3, 5, and 7 do not have to be factors, but it should not have any other prime factors.
	For example, the first several multiples would be (in order) 1, 3, 5, 7, 9, 15, 21
*/

func kthMultiple(k: Int) {
	var arr: [Int] = [1, 3, 5, 7]
	let set: Set<Int> = [3, 5, 7]
	guard k > 4 else {
		if k < 0 {
			return
		}
		print(arr[0..<k])
		return
	}	
	
	var currentNum = 8
	outer: while arr.count < 7 {
		print("currentNumber is \(currentNum)")
		for i in 2..<currentNum {
			if isPrime(i) {
				if !set.contains(i) {
					currentNum += 1
					continue outer
				}
			}
		}
		arr.append(currentNum)
		currentNum += 1
	}

	print(arr)
}

func isPrime(_ num: Int) -> Bool {
	let commonPrimes: Set<Int> = [2, 3, 5, 7]
	guard !commonPrimes.contains(num) else { return true }
	for i in 2..<num/2 + 1 {
		if num % i == 0 {
			return false
		}
	}
	return true
}

kthMultiple(k: 5)
kthMultiple(k: 7)
kthMultiple(k: 10)