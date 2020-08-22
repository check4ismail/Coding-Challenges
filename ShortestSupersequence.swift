/*
	Shortest Supersequence: You are given two arrays, one shorter (with all distinct elements) and one longer.
	Find the shortest subarray in the longer array that contains all the elements in the shorter array. The items can appear in any order.

	Example:
	Input: {1, 5, 9} | {7, 5, 9, 0, 2, 1, 3, 5, 7, 9, 1, 1, 5, 8, 8, 9, 7}
	Output: [7, 10]

	To run this solution, enter the following commands in Terminal:
	1. swift ShortestSupersequence.swift
*/

// Struct to keep track of startIndex and endIndex
// Conformed to Comparable so struct can be stored in an array and be sorted easily

import Foundation

struct IndexTracker: CustomStringConvertible, Comparable {
	let startIndex: Int
	let endIndex: Int
	
	public var description: String {
		"{\(startIndex),\(endIndex)}"
	}
	
	static func ==(lhs: IndexTracker, rhs: IndexTracker) -> Bool {
		if (lhs.endIndex - lhs.startIndex) == (rhs.endIndex - rhs.startIndex) {
			return true
		} else {
			return false
		}
	}
	
	static func >(lhs: IndexTracker, rhs: IndexTracker) -> Bool {
		if (lhs.endIndex - lhs.startIndex) > (rhs.endIndex - rhs.startIndex) {
			return true
		} else {
			return false
		}
	}
	
	static func <(lhs: IndexTracker, rhs: IndexTracker) -> Bool {
		if (lhs.endIndex - lhs.startIndex) < (rhs.endIndex - rhs.startIndex) {
			return true
		} else {
			return false
		}
	}
}

func shortestSuperSequence(shorter: [Int], longer: [Int]) -> [IndexTracker] {
	var start = 0
	var end = 0
	var set: Set<Int> = []
	var superSequences: [IndexTracker] = []
	
	for i in 0..<longer.count {
		for j in 0..<shorter.count {
			
			// Checks to see if value from longer matches any of the values from shorter
			// If it's the first time element is added to set, startIndex is set to i
			if longer[i] == shorter[j] && !set.contains(shorter[j]) {
				if set.count == 0 {
					start = i
				}
				set.insert(shorter[j])
			}
		}
		
		// If all elements from shorter were added to set,
		// append IndexTracker object to keep track of start and end indexes
		if set.count == shorter.count {
			end = i
			superSequences.append(IndexTracker(startIndex: start, endIndex: end))
			set.removeAll()
		}
	}
	
	// If superSequences is empty, return an empty array
	guard !superSequences.isEmpty else { return [] }
	
	superSequences.sort{ $0 < $1 }
	
	// Return the shortest super sequence
	return [superSequences[0]]
}

print(shortestSuperSequence(shorter: [1, 5, 9], longer: [7, 5, 9, 0, 2, 1, 3, 5, 7, 9, 1, 1, 5, 8, 8, 9, 7]))
