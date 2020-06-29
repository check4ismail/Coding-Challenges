/*
	Pairs with sum: Design an algorithm to find all pairs of integers within an array
	which sum to a specified value
*/
func pairsSpecificValue(sum: Int, arr: [Int]) -> Set<[Int]> {
	
	// 1. Sort array
	guard arr.count > 1 else {
		return []
	}

	// 2. Verify count > 1 & if sum is possible to begin with....otherwise return empty set
	var arr = arr
	arr.sort(by: <)
	guard arr[0] + arr[1] < sum else {
		return []
	}

	// Simply create a set of Int arrays
	var set: Set<[Int]> = []

	// Loop through all potential array pairs
	for i in 0..<arr.count-1 {
		for j in i+1..<arr.count {
			if arr[i] + arr[j] == sum {
				set.insert([arr[i], arr[j]])
			}
		}
	}

	return set
}

// Pairs that add up to 3
print("Pairs that add up to 3\n\(pairsSpecificValue(sum: 3, arr: [0, 1, 2, 3]))\n")

// Pairs that add up to 15
print("Pairs that add up to 15\n\(pairsSpecificValue(sum: 15, arr: [0, 1, 2, 7, 15, 8, 10, 5, 6, 9, 16]))\n")

// Pairs that add up to 5
print("Pairs that add up to 5\n\(pairsSpecificValue(sum: 5, arr: [0, 1, 2, 7, 4, 15, 8, 10, 5, 6, 9, 16]))\n")

// Pairs that add up to 2
print("Pairs that add up to 2\n\(pairsSpecificValue(sum: 2, arr: [7, 4, 15, 8, 10, 5, 6, 9, 16]))\n")

// Array with only 1 element
print("Array with only one element\n\(pairsSpecificValue(sum: 2, arr: [7]))\n")

// Array with 2 elements that clearly don't add up to sum
print("Array with first sum greater than given sum\n\(pairsSpecificValue(sum: 2, arr: [1, 2]))\n")