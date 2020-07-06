import Foundation

public func randomSet(m: Int, n: Int) -> [Int] {
	var set: Set<[Int]> = []
	var numbers: [Int] = []

	for _ in 0..<n { numbers.append(Int.random(in: 1...10000)) } // Random number between 1 & 10,000

	// if m is equal to 1
	guard m > 1 else {
		for number in numbers { set.insert([number]) }
		print("Original array with length \(n) - \(numbers)")
		print("Set with \(m) numbers - \(set)")
		return set.randomElement()!
	}

	// if m is equal to n
	guard m < n else {
		set.insert(numbers)
		print("Original array with length \(n) - \(numbers)")
		print("Set with \(m) numbers - \(set)")
		return set.randomElement()!
	}

	// Otherwise
	for i in 0...numbers.count-m {
		var tempArr: [Int] = []
		tempArr.append(numbers[i]) 	// Add at index i
		
		var incrementBy: Int = 1 	// Increases currentIndex starting point
		var currentIndex = i + incrementBy
		
		while currentIndex < numbers.count {
			tempArr.append(numbers[currentIndex])
			if tempArr.count >= m {
				set.insert(tempArr)
				
				tempArr = []	// Empty array
				tempArr.append(numbers[i])	// At numbers[i] again

				// Start at i + 2, then i + 3...etc to cover all potential sets
				incrementBy += 1
				currentIndex = i + incrementBy
			} else {
				currentIndex += 1
			}
		}
	}
	print("Original array with length \(n) - \(numbers)")
	print("Set with \(m) numbers - \(set)")
	return set.randomElement()!
}
print(randomSet(m: 1, n: 5))
print("\n")
print(randomSet(m: 2, n: 5))
print("\n")
print(randomSet(m: 5, n: 5))
print("\n")
print(randomSet(m: 5, n: 6))
