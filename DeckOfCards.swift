/*
	Designing deck of cards in an object oriented fashion
	To run the program, enter the following in your terminal (in the main directory of CodingChallenges): 
	1) swiftc -o main DeckOfCards.swift main.swift
	2) ./main
*/
struct Card {
	let suite: Suite
	let digit: Int
	let nonDigit: NonDigitCard?
}
extension Card: CustomStringConvertible {
	var description: String {
		switch digit {
		// although force unwrapping an optional isn't ideal in any situation,
		// it's safe to say it won't be a problem here!
		case 11:
			return "\(nonDigit!.rawValue) of \(suite.rawValue)\n"
		case 12:
			return "\(nonDigit!.rawValue) of \(suite.rawValue)\n"
		case 13:
			return "\(nonDigit!.rawValue) of \(suite.rawValue)\n"
		case 14:
			return "\(nonDigit!.rawValue) of \(suite.rawValue)\n"
		default:
			return "\(digit) of \(suite.rawValue)\n"
		}
	}
}

enum NonDigitCard: String {
	case king = "king"
	case queen = "queen"
	case jack = "jack"
	case ace = "ace"
}

enum Suite: String, CaseIterable {
	case hearts = "hearts"
	case clubs = "clubs"
	case diamonds = "diamonds"
	case spades = "spades"
}
struct Deck: CustomStringConvertible {
	private var deckOfCards: [Card] = []
	
	var description: String { "\(deckOfCards)" }
	var count: Int { deckOfCards.count }
	
	init() {
		createDeck()
	}	
	
	private mutating func createDeck() {
		for suite in Suite.allCases {
			for i in 2...14 {
				switch i {
				case 11:
					deckOfCards.append(Card(suite: suite, digit: i, nonDigit: .jack))
				case 12:
					deckOfCards.append(Card(suite: suite, digit: i, nonDigit: .king))
				case 13:
					deckOfCards.append(Card(suite: suite, digit: i, nonDigit: .queen))
				case 14:
					deckOfCards.append(Card(suite: suite, digit: i, nonDigit: .ace))
				default:
					deckOfCards.append(Card(suite: suite, digit: i, nonDigit: nil))
				}
			}
		}
	}

	mutating func drawCard() -> Card? {
		guard !deckOfCards.isEmpty else { return nil }
		return deckOfCards.removeLast()
	}

	mutating func shuffleDeck() {
		deckOfCards.shuffle()
	}
}

func main() {
	var deck = Deck()
	print(deck)
	print("Total cards in deck: \(deck.count)")

	deck.shuffleDeck()
	print("\nAfter shuffling deck")
	print(deck)

	print("\nDrawing a card")
	if let card = deck.drawCard() { print(card) }
	print("Total cards in deck: \(deck.count)")
}