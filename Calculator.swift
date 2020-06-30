/*
	Calculator: Given an arithmetic equation consisting of positive integers, +, -, * and / (no paranthesis),
	compute the result
*/
import Foundation

// Struct for Queue - Doubly Linked List is more efficient, but went with Array for now
public struct Queue<T> {
	var elements: [T] = []
	public init(){}
	
	public var count: Int {
		elements.count
	}
	
	public var isEmpty: Bool {
		elements.isEmpty
	}
	
	public mutating func enqueue(_ element: T) {
		elements.append(element)
	}
	
	public mutating func dequeue() -> T? {
		guard !isEmpty else {
			return nil
		}
		return elements.removeFirst()
	}
}

func calculator(_ str: String) {
	
	var arr: [String] = []
	let digits: [String] = str.components(separatedBy: ["+", "-", "*", "/"]) // All digits
	let operations = str.filter { "+-/*".contains($0) }	// all operations
	
	var queueOperation = Queue<String>()
	operations.forEach {  queueOperation.enqueue("\($0)") } // operations in queue
	for digit in digits {
		arr.append(digit)
		if let operation = queueOperation.dequeue() {
			arr.append(operation)
		}
	}
	print(arr) // arr now contains digits and operations in order
	
	// From left to right, if * or /, perform operation
	while let index = arr.firstIndex(where: { $0 == "*" || $0 == "/" }) {
		if let leftDigit = Double(arr[index - 1]), 
			let rightDigit = Double(arr[index + 1]) {
			let finalDigit = arr[index] == "*" ? leftDigit * rightDigit : leftDigit / rightDigit
			arr.remove(at: index - 1)
			arr.remove(at: index)
			arr[index - 1] = "\(finalDigit)"
		}
		//let rightDigit = Double(arr[index + 1])
		//let finalDigit = arr[index] == "*" ? leftDigit * rightDigit : leftDigit / rightDigit
		
	}
	// From left to right, if + or - perform operation
	while let index = arr.firstIndex(where: { $0 == "+" || $0 == "-" }) {
		if let leftDigit = Double(arr[index - 1]),
			let rightDigit = Double(arr[index + 1]) {
			let finalDigit = arr[index] == "+" ? leftDigit + rightDigit : leftDigit - rightDigit
			arr.remove(at: index - 1)
			arr.remove(at: index)
			arr[index - 1] = "\(finalDigit)"
		}
	}

	// Final element remaining is the result
	print(arr[0])
}

calculator("2*3+5/6*3+15")
calculator("2*3+5/6*3+25")