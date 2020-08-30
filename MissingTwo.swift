/*
	You are given an array with all the numbers from 1 to N appearing exactly once, except for one number
	that is missing. How can you find the missing number in O(n) time and O(1) space?
	What if there were two numbers missing?
*/

// Finds missing numbers
private func missingTwo(_ arr: [Int]) -> [Int] {
	var currentNumber = arr[0]
	var missingNumbers: [Int] = []
	
	for digit in arr {
		if currentNumber == digit {
			currentNumber += 1
		} else {
			let difference = digit - currentNumber
			missingNumbers.append(currentNumber)
			currentNumber += difference + 1
		}
	}
	
	return missingNumbers
}

// Create an array from any starting number to ending number
// Example - 1 to 50, 5 to 10, etc....
private func generateArray(from start: Int, to end: Int) -> [Int] {
	var newArr: [Int] = []
	for number in start...end {
		newArr.append(number)
	}
	return newArr
}

// Returns a random index, which can be removed
private func generateRandom(_ count: Int) -> Int {
	return Int.random(in: 0..<count - 1)
}

enum Missing: String {
	case one = "one"
	case two = "two"
}

// Determines whether one or two numbers should be missing, then prints out to console
private func missingOneOrTwo(_ arr: inout [Int], _ missing: Missing) {
	switch missing {
	case .one:
		arr.remove(at: generateRandom(arr.count))
	case .two:
		arr.remove(at: generateRandom(arr.count))
		arr.remove(at: generateRandom(arr.count))
	}
	
	print("Array with \(missing.rawValue) missing number")
	print(arr)
	print("Missing \(missing.rawValue) number: \(missingTwo(arr))\n")
}

func main() {
	var arr = generateArray(from: 1, to: 50)
	missingOneOrTwo(&arr, .one)
	
	arr = generateArray(from: 1, to: 25)
	missingOneOrTwo(&arr, .one)
	
	arr = generateArray(from: 10, to: 30)
	missingOneOrTwo(&arr, .two)
}
