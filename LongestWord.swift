/*
	Longest Word: Given a list of words, write a program to find the longest word made of other words in the list.
	
	Example:
	Input: cat, banana, dog, nana, walk, walker, dogwalker
	Output: dogwalker

	To run this solution, enter the following commands via Terminal:
	1. swiftc -o main LongestWord.swift main.swift data-structures/Trie.swift
	2. ./main
*/

func longestWord(_ words: [String]) -> String? {
/*
	Brief summary regarding this solution:
	1. Add all elements of words into a Trie
	2. Created a custom method in Trie class that counts number of words within a word
	3. If longestWord is greater than default word count of 1, return the longestWord! Otherwise return nil
*/
	// words should be greater than 1
	guard words.count > 1 else {
		return nil
	}
	
	let trie = Trie<String>()
	// insert all elements of words into Trie
	words.forEach{ trie.insert($0) }
	
	var longestWord: String = ""
	var largestWordCount = 1
	
	for word in words {
		let wordCount = trie.wordCount(word)
		
		// continue with next iteration if word count is 1
		if wordCount == 1 {
			continue
		}
		
		// 1. must be greater or equal to current largest word
		// 2. length of word should be greater than current longestWord
		if wordCount >= largestWordCount &&
			word.count > longestWord.count {
			largestWordCount = wordCount
			longestWord = word
		}
	}
	return largestWordCount > 1 ? longestWord : nil
}

func main() {
	var words: [String] = ["cat", "banana", "dog", "nana", "walk", "walker", "dogwalker"]
	let message = "nil"
	print("Input: \(words)")
	print("Output: \(longestWord(words) ?? message)\n")
	
	words = ["web", "site", "website", "what"]
	print("Input: \(words)")
	print("Output: \(longestWord(words) ?? message)\n")

	words = ["good", "morning", "hello", "random"]
	print("Input: \(words)")
	print("Output: \(longestWord(words) ?? message)\n")

	words = ["fail"]
	print("Input: \(words)")
	print("Output: \(longestWord(words) ?? message)\n")
}
