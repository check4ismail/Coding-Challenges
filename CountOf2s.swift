/*
	Count of 2s: Write a method to count the number of 2s that appear in all numbers
	between 0 and n (inclusive)
*/
public func countTwos(n: Int) {
	// If n equals 2 or less
	guard n > 2 else {
		if n == 2 {
			print("1 - \(2)")
		} else {
			print("0")
		}
		return
	}

	var str: String = ""	// keeps track of all values containing 2
	var count = 0			// keeps count of 2s found
	var base = 1			
	for i in 0...n {
		
		if i % 10 == 0 && i / 10 == base { // applies if value is 10, 100, 1000, etc - updates dynamically
			base *= 10
		}

		if i % base == 2 && i / base == 2 {		// this case applies to 22
			str += "\(i) "
			count += 2
		} else if i % base == 2 {				// this case applies to 32
			str += "\(i) "
			count += 1
		} else if i / base == 2 {				// this case applies to 25
			str += "\(i) "
			count += 1
		}
	}
	print("\(count) - \(str)")
}

countTwos(n: -1)
countTwos(n: 1)
countTwos(n: 2)
countTwos(n: 25)
countTwos(n: 32)
countTwos(n: 102)