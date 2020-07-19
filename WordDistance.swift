/*
	Word distance: You have a large text file containing words. Given any two words, find the shortest
	distance (in terms of words) between them in the file. If the operation will be repeated many times 
	for the same file (but different pairs of words) can you optimize your solution?

	To run this file via terminal, enter the following commands:
	1) swiftc -o main WordDistance.swift main.swift
	2) ./main
*/

import Foundation

func wordDistance(_ wordA: String, _ wordB: String, _ wordsIndex: inout [String: Int]) -> Int? {
	
	// If word is already cached via dictionary
	if wordsIndex[wordA] != nil && wordsIndex[wordB] != nil {
		print("Distance calculated from dictionary")
		return calculateDistance(wordA, wordB, wordsIndex)
	}
	
	let filename = "words.txt"
	let contents = try! String(contentsOfFile: filename)
	let lines = contents.split(separator: "\n")
	var wordAFound = false
	var wordBFound = false
	
	// If all words are cached already but one or two of words
	// not in dictionary, return nil
	if lines.count == wordsIndex.count {
		print("One or two words not found")
		return nil
	}

	for i in 0..<lines.count {
		if wordAFound && wordBFound {
			break
		}
		
		if wordA == lines[i] {
			wordsIndex[String(wordA)] = i
			wordAFound = true
		} else if wordB == lines[i] {
			wordsIndex[String(wordB)] = i
			wordBFound = true
		} else {
			// Cache word with its index
			wordsIndex[String(lines[i])] = i
		}
	}
	if !wordAFound || !wordBFound { // if either wordA or wordB isn't found, return nil
		print("One or two words not found")
		return nil
	}
	print("Distance calculated via iteration of file")
	return calculateDistance(wordA, wordB, wordsIndex)
}

func calculateDistance(_ wordA: String, _ wordB: String, _ wordsIndex: [String: Int]) -> Int {
	var distance = wordsIndex[wordA]! - wordsIndex[wordB]! - 1
	distance = distance < 0 ? distance * -1 : distance * 1	// If negative, make it positive
	return distance
}

func main() {
	var wordsIndex: [String: Int] = [:]
	
	var wordA = "arithmetic"
	var wordB = "simplistic"
	print("Distance between \(wordA) and \(wordB) is \(wordDistance(wordA, wordB, &wordsIndex)!) words\n")	//Index 0 and 27
	
	wordA = "religion"
	wordB = "fold"
	print("Distance between \(wordA) and \(wordB) is \(wordDistance("arithmetic", "simplistic", &wordsIndex)!) words\n")	//Index 4 and 21 - cached

	wordA = "smile"
	wordB = "cheat"
	print("Distance between \(wordA) and \(wordB) is \(wordDistance(wordA, wordB, &wordsIndex)!) words\n")	//Index 10 and 35 - not cached yet
	
	wordA = "worried"
	wordB = "quill"
	print("Distance between \(wordA) and \(wordB) is \(wordDistance(wordA, wordB, &wordsIndex)!) words\n")	//Index 24 and 34 - cached
	
	wordA = "best"
	wordB = "obese"
	print("Distance between \(wordA) and \(wordB) is \(wordDistance(wordA, wordB, &wordsIndex)) words\n") // returns nil
}