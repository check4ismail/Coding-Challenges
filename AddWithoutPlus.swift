/*
	Add Without Plus: Write a function that adds two numbers. You should not use + or any arithmetic operators.
*/

public func addWithoutPlus(_ a: Int, _ b: Int) -> Int {
	if b == 0 {
		return a
	} else {
		return addWithoutPlus(a ^ b, (a & b) << 1)
	}
}
let a = Int.random(in: 1...1000)
let b = Int.random(in: 1...1000)
print("\(a) + \(b) = \(addWithoutPlus(a, b))")