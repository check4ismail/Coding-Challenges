/*
	Coding challenge question:
	Write a method that generates a random number between 0 and 6 (inclusively)
*/
import Foundation
func generateRandomNumber(between low: Int, and high: Int, inclusive: Bool) -> Int {
	let date = Int(NSDate().timeIntervalSince1970)
	let random = inclusive ? date % (high + 1) + low : date % high + low
	return random	
}
print(generateRandomNumber(between: 0, and: 6, inclusive: true))