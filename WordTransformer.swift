/*
	Word Transformer: Given two words of equal length that are in a dictionary, write a method to transform one word into another
	word by changing only one letter at a time. The new word you get in each step must be in the dictionary.

	EXAMPLE:
	Input: DAMP, LIKE
	Output: DAMP -> LAMP -> LIMP -> LIME -> LIKE

	To run this program, enter the following commands:
	1. swiftc -o main main.swift WordTransformer.swift data-structures/Trie.swift
	2. ./main
*/
private func wordTransformer(with dictionary: Trie<String>, _ wordA: String, _ wordB: String) -> String {
	// Error handling for edge cases
	guard wordA.count == wordB.count else {
		return "Words don't have the same length, invalid combination"
	}
	guard !wordA.isEmpty && !wordB.isEmpty else {
		return "wordA and wordB are empty"
	}
	
	var wordTransformed: String = wordA			// Is used to display an elegant word transformation
	var wordsTracker: Set<String> = [wordA]		// Will help with preventing duplicate string insertions
	var arrA = Array(wordA)
	let arrB = Array(wordB)
	
	for i in 0..<arrA.count {
		arrA[i] = arrB[i]
		let newWord = String(arrA)
		if !wordsTracker.contains(newWord) && dictionary.contains(newWord) {
			wordsTracker.insert(newWord)
			wordTransformed += " -> \(newWord)"
		}
		for j in i + 1..<arrA.count {
			let prev = arrA[j]
			arrA[j] = arrB[j]
			let newWord = String(arrA)
			if !wordsTracker.contains(newWord) && dictionary.contains(newWord) {
				wordsTracker.insert(newWord)
				wordTransformed += " -> \(newWord)"
			}
			arrA[j] = prev
		}
	}
	
	return wordTransformed
}

func main() {
	var tempDictionary = Trie<String>()
	tempDictionary.insert("damp")
	tempDictionary.insert("lamp")
	tempDictionary.insert("limp")
	tempDictionary.insert("lime")
	tempDictionary.insert("like")
	var wordA = "damp"
	var wordB = "like"
	print(wordTransformer(with: tempDictionary, wordA, wordB))
	
	// Probably not an accurate dictionary, but demonstrating that it works
	tempDictionary = Trie<String>()
	tempDictionary.insert("flake")
	tempDictionary.insert("steak")
	tempDictionary.insert("fleak")
	tempDictionary.insert("stake")
	tempDictionary.insert("steke")
	wordA = "flake"
	wordB = "steak"
	print(wordTransformer(with: tempDictionary, wordA, wordB))
	
	// Will return an error message
	wordA = "bike"
	wordB = "fight"
	print(wordTransformer(with: tempDictionary, wordA, wordB))
	
	// Another use case that'll return an error message
	wordA = ""
	wordB = "fight"
	print(wordTransformer(with: tempDictionary, wordA, wordB))
	
	// Another use case that'll return an error message
	wordA = ""
	wordB = ""
	print(wordTransformer(with: tempDictionary, wordA, wordB))
}
