/*
	Re-Space: Oh no! You have accidentally removed all spaces, punctuation and capitalization in a lengthy
	document. A sentence like "I reset the computer. It Still didn't boot!" became
	"iresetthecomputeritstilldidntboot". You'll deal with the punctuation and capitalization later; right now
	you need to re-insert the spaces. Most of the words are in a dictionary but a few are not.

	Given a dictionary (a list of strings) and the document (a string), design an algorithm to unconcatenate the
	document in a way that minimizes the number of unrecognized characters.

	Example:
	Input: jesslookedjustliketimherbrother
	Output: jess looked just like tim her brother (7 unrecognized characters)

	To run this solution, enter the following commands via Terminal:
	1) swiftc -o main ReSpace.swift main.swift data-structures/Trie.swift
	2) ./main
*/
import Foundation

func reSpace(doc: String, _ dictionary: Trie<String>) {
	let arr = Array(doc)				// Used to iterate through all words
	var allWords = arr					// Copy of arr, but inserts comma once words are actually found via iteration
	var totalWordsFound: [String] = []	// Keeps track of all legitimate words found
	var wordsFound: [String] = []		// Temp store for words found that may be similar; example - look, looked -> looked should be selected
	let lastIndex = arr.count - 1
	var done = false					// If last word stretches through last index, prevents further iteration
	
	var firstLetterIndex = 0			// First index of official word found
	var lastLetterIndex = 0				// Last index of official word found
	var indexIncrease = 0				// Keeps track of allWords count increase
	
	outer: for i in 0..<arr.count {
		if !wordsFound.isEmpty {
			// In case there are 2 or more words found through one iteration,
			// it will add the longest word which is the last element
			totalWordsFound.append(wordsFound.last!)
			
			// Empty wordsFound for re-use during next iteration via inner for loop
			wordsFound = []
			
			// Prevent adding a comma at index 0
			if firstLetterIndex != 0 {
				allWords.insert(",", at: firstLetterIndex + indexIncrease)
				indexIncrease += 1
			}
			
			// Prevent adding a comma at last index
			if lastLetterIndex < allWords.count - 1 {
				allWords.insert(",", at: lastLetterIndex + indexIncrease)
				indexIncrease += 1
			}
		}
		
		if done {
			break
		}
		
		firstLetterIndex = i
		var str = ""
		for j in i..<arr.count {
			str += "\(arr[j])"
			
			// Verifies if word pattern actually exists in dictionary
			if dictionary.potentialContains(str) {
				// Verifies if word is valid
				if dictionary.contains(str) {
					lastLetterIndex = j + 1
					wordsFound.append(str)		//add valid word(s) during this iteration
					done = j == lastIndex ? true : false
				}
			} else {
				// this step prevents continuation of current inner loop - making it
				// MORE efficient than traditional nested loop approach
				continue outer
			}
		}
	}
	
	let str = String(allWords) //transform to String
	let arrStr = str.components(separatedBy: ",")	//separate by commas
	let finalAllWords = arrStr.filter{ $0 != "" }	//in case there are empty strings added, they're filtered out
	
	let actualWords = totalWordsFound.joined(separator: "") //transform array of strings to string
	let charDifference = doc.count - actualWords.count	// Unrecognized character difference
	print("\(finalAllWords) - \(charDifference) unrecognized characters")
}


func main() {
	/*
		Sample dictionary for this purpose.
		But to add more words, I can easily have a text file with a list of hundreds of random words,
		iterate through them and insert them into this Trie.
	
		For now, keeping this example simple to demonstrate solution
	*/
	let dictionary = Trie<String>()
	dictionary.insert("looked")
	dictionary.insert("just")
	dictionary.insert("like")
	dictionary.insert("her")
	dictionary.insert("brother")
	dictionary.insert("jet")
	
	reSpace(doc: "jesslookedjustliketimherbrother", dictionary)
}
