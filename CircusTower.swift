/*
	Circus Tower: A circus is designing a tower routine consisting of people standing atop one another's shoulders.
	For practical and aesthetic reasons, each person must be both shorter and lighter than the person below him or her.
	Given the heights and weights of each person in the circus, write a method to compute the largest possible number
	of people in such a tower.

	Example
	Input (ht, wt): (65, 100), (70, 150) (56, 90) (75, 190) (60, 95) (68, 110)
	Output: The longest tower is length 6 and includes from top to bottom:
		(56, 90) (60, 95) (65, 100) (68, 110) (70, 150) (75, 190)

	To run this solution, simply enter the following command via Terminal:
	- swift CircusTower.swift
*/

import Foundation

// Creating a custom struct, then overriding operators for > and < comparison 
public struct Tower: Equatable, CustomStringConvertible {
	let height: Int
	let weight: Int

	public var description: String { "(\(height), \(weight))" }

	public init(_ height: Int, _ weight: Int) {
		self.height = height
		self.weight = weight
	}

	public static func ==(lhs: Tower, rhs: Tower) -> Bool {
		if lhs.height == rhs.height && lhs.weight == rhs.weight {
			return true
		}
		return false
	}
	public static func <(lhs: Tower, rhs: Tower) -> Bool {
		if lhs.height < rhs.height {
			if lhs.weight < rhs.weight {
				return true
			}
			return false
		}
		return false
	}

	public static func >(lhs: Tower, rhs: Tower) -> Bool {
		if lhs.height > rhs.height {
			if lhs.weight > rhs.weight {
				return true
			}
			return false
		}
		return false
	}
}

public func printCircusTower(_ arr: [Tower]) {
	guard arr.count > 1 else { return }
	
	var arr = arr
	arr.sort(by: <) // Sort by greater than

	// If there's a Tower object that was not less than any of the Tower objects,
	// then it will be the last of elements
	// This loop will dynamically remove objects from array 
	var currentIndex = arr.count - 1
	var nextIndex = currentIndex - 1
	while nextIndex >= 0 {
		if !(arr[nextIndex] < arr[currentIndex]) {
			arr.removeLast()
			currentIndex -= 1
			nextIndex = currentIndex - 1
		} else {
			break
		}
	}

	print("Circus tower count: \(arr.count)")
	arr = arr.reversed()	// Reversing so order can display from largest to smallest tower
	print("\(arr)\n")
}

var arr: [Tower] = [Tower(65, 100), Tower(70, 150), Tower(56, 90), Tower(75, 190), Tower(60, 95), Tower(68, 110)]
print("Original heights and weights")
print(arr)
printCircusTower(arr)

arr = [Tower(65, 100), Tower(70, 150), Tower(56, 90), Tower(75, 190), Tower(60, 95), Tower(68, 200)]	// Added weight that was off
print("Original heights and weights")
print(arr)
printCircusTower(arr)