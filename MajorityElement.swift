/*
	Majority element: A majority element is an element that makes up more than half of the items in an array.
	Given a positive integers array, find the majority element. If there is no majority element, return -1
*/
func majorityElement(_ arr: [Int]) -> Int {
	guard !arr.isEmpty else { return -1 }
	guard arr.count > 1 else { return arr[0] }

	var counterList: [Int: Int] = [:]
	let majority = arr.count / 2 + 1

	for number in arr {
		if counterList[number] == nil {
			counterList[number] = 1
		} else {
			counterList[number]! += 1 // increment counter
			if counterList[number]! >= majority { // checks to see if majority element exists
				return number
			}
		}
	}

	return -1
}

print(majorityElement([1, 2, 5, 9, 5, 9, 5, 5, 5]))		// returns 5
print(majorityElement([1, 2, 5, 9, 5, 9, 5, 5]))		// returns -1
print(majorityElement([1, 2, 5, 9, 5, 9, 10, 11, 12]))	// returns -1
print(majorityElement([]))	// returns -1
print(majorityElement([1]))	// returns 1