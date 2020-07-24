/*
	SmallestK: Design an algorithm to find the smallest K numbers in an array
	To run program, enter the following commands in terminal:
	1) swiftc -o main SmallestK.swift main.swift
	2) ./main
*/

func smallestK(k: Int, _ arr: [Int]) {
	guard k > 0 else {
		print("k: \(k) -> k must be greater than 0")
		return
	}
	guard k <= arr.count else {
		print("k: \(k) -> k can't be larger than array size")
		return
	}
	var arrOfK: [Int] = []
	for i in 0..<k {
		arrOfK.append(arr[i])
	}
	print("k: \(k) -> \(arrOfK)")
}

func main() {
	var arr: [Int] = []
	let last = Int.random(in: 10...20)	// random size for array - can range from 10 to 20
	for _ in 0..<last {
		arr.append(Int.random(in: 1...1000))
	}
	print("Array - before sort: \(arr)")	// Unsorted
	arr.sort(by: <)	// sort array in ascending order
	print("Array - after sort: \(arr)")	// Sorted
	
	smallestK(k: 1, arr)
	smallestK(k: 5, arr)
	smallestK(k: 10, arr)
	smallestK(k: 30, arr)	// k larger than array size
	smallestK(k: 0, arr)	// k with value of 0
	smallestK(k: -1, arr)	// k with value of 0
}
