/*
	Missing number: an array A contains all the integers from 0 to n, except for one number
	which is missing. In this problem, we cannot access an entire integer in A with a single 
	operation. The elements of A are represented in binary and the only operation we can use to 
	access them is "fetch the jth bit of A[j]", which takes constant time. 

	Write code to find the missing integer.
*/

public func findMissingNumber(_ a: [Int]) -> Int? {
	var aComplete: [Int] = []
	for index in 0...a.count { aComplete.append(index) } // same as a, but has missing number

	for i in 0..<a.count {
		for j in 0..<numberOfBits(n: aComplete[i]) { // iterates through number of bits
			if getBit(n: a[i], at: j) != 
				getBit(n: aComplete[i], at: j) {	// if they're not equal, that's the missing number!
				return aComplete[i]
			}
		}
	}

	return nil
}

// Get bit at j
public func getBit(n: Int, at j: Int) -> Int {
	let mask = (1 << j)
	return mask & n
}

// Get number of bits of a digit
public func numberOfBits(n: Int) -> Int {
	var n = n
	var count = 0
	while n != 0 {
		count += 1
		n = n >> 1
	}
	return count
}

func main() {
	var a: [Int] = []
	let randomMax = Int.random(in: 10...500)
	for i in 0...randomMax { a.append(i) }
	print("Full array: \(a)")
	
	let removeRandom = Int.random(in: 1..<a.count-1)
	a.remove(at: removeRandom)
	print("After removing element: \(a)")

	if let missingNum = findMissingNumber(a) { 
		print("Missing number is: \(missingNum)") 
	} else {
		print("No missing number")
	}
}