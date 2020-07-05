/*
	Shuffle: Write a method to shuffle a deck of cards. It must be a perfect shuffle - in other words,
	each of the 52! permutations of the deck has to be equally likely. Assume that you are given a random
	number generator which is perfect
*/

// Struct created to display a nice deck of cards
public struct Cards {
	let cardSuite = ["Clover", "Heart", "Diamond", "Spade"]
	let cards = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "King", "Queen", "Ace"]
	var deck: [String] {
		var arr: [String] = []
		for suite in cardSuite {
			for card in cards {
				let cardCreator = "\(card)-\(suite)"
				arr.append(cardCreator)
			}
		}
		return arr
	}
	public init() {}
}

// Shuffle deck - may possibly swap with itself
public func shuffle(_ deck: [String]) -> [String] {
	var deck = deck
	for i in 0..<deck.count {
		let rand = Int.random(in: i..<deck.count)
		deck.swapAt(i, rand)
	}
	return deck
}

// Print out deck
public func displayDeck(_ deck: [String]) {
	var str = ""
	for i in 0..<deck.count {
		str += "\(deck[i]), "
		if i % 13 == 0 && i != 0 {
			print(str)
			str = ""
		}
	}
}

print(displayDeck(Cards().deck))
print(displayDeck(shuffle(Cards().deck)))