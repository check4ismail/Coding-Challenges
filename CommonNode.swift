/*
	LinkedList class implementation with common node method
	To run this file, enter the following commands via Terminal:
	1) swiftc -o main CommonNode.swift main.swift
	2) ./main
*/

public class Node<T>: CustomStringConvertible {
	public var value: T
	public var next: Node?

	public var description: String { "\(value)" }
	public init(value: T, next: Node? = nil) {
		self.value = value
		self.next = next
	}
}

public struct LinkedList<T>: CustomStringConvertible {
	private var head: Node<T>?
	private var tail: Node<T>?

	public init() {}

	public var isEmpty: Bool { head == nil }

	public var description: String {
		guard !isEmpty else { return "Empty list" }
		var current = head
		var str = ""
		while let node = current {
			str += "-> \(node) "
			current = current!.next
		}
		return str
	}

	// Avoid copy-on-write
//	private mutating func copyNodes() {
//		guard !isKnownUniquelyReferenced(&head) else { return }
//		guard var oldNode = head else { return }
//
//		head = Node(value: oldNode.value)
//		var newNode = head
//		while let nextOldNode = oldNode.next {
//			newNode!.next = Node(value: nextOldNode.value)
//			newNode = newNode!.next
//			oldNode = nextOldNode
//		}
//		tail = newNode
//	}

	public mutating func push(_ value: T) {
//		copyNodes()
		head = Node(value: value, next: head)
		if tail == nil {
			tail = head
		}
	}

	public mutating func append(_ value: T) {
		guard !isEmpty else { 
			push(value)
			return
		}
//		copyNodes()
		var current = head
		var prev = current
		while current != nil {
			prev = current
			current = current!.next
		}
		prev!.next = Node(value: value)
		tail = prev!.next
	}

	@discardableResult
	public mutating func pop() -> T? {
//		copyNodes()
		defer {
			head = head?.next
			if head == nil {
				tail = nil
			}
		}
		return head?.value
	}

	@discardableResult
	public mutating func removeLast() -> T? {
//		copyNodes()
		guard let head = head else { return nil }
		guard head.next != nil else { return pop() }
		var prev = head
		var current = head
		while let next = current.next {
			prev = current
			current = next
		}
		prev.next = nil
		tail = prev
		return current.value
	}

	public func node(at index: Int) -> Node<T>? {
		var current = head
		var currentIndex = 0

		while current != nil && currentIndex < index {
			current = current!.next
			currentIndex += 1
		}

		return current
	}

	public func findCommonNode(_ listB: LinkedList<T>) -> Node<T>? {
		let listA = self
		guard !listA.isEmpty && !listB.isEmpty else { return nil }

		var indexOfA = 0
		var indexOfB = 0
		while let nodeA = listA.node(at: indexOfA) {
			while let nodeB = listB.node(at: indexOfB) {
				if nodeA === nodeB { // If common node is found
					return nodeA
				}
				indexOfB += 1
			}
			indexOfA += 1
			indexOfB = 0
		}
		return nil
	}
}

func main() {
	// Two linked lists
	var list1 = LinkedList<Int>()
	var list2 = LinkedList<Int>()

	for _ in 0..<5 {
		list1.append(Int.random(in: 1...100))
	}
	
	// List 2 is like list 1....for now
	list2 = list1

	// List 2 and 1 have different values in the front
	for _ in 0..<3 {
		list2.push(Int.random(in: 1...100))
		list1.push(Int.random(in: 1...100))
	}
	
	// Both list 1 and list 2 share common nodes
	print(list1)
	print(list2)
	
	
	// Printing the first common node
	if let commonNode = list1.findCommonNode(list2) {
		print("First common node between list1 and list2 is: \(commonNode)")
	}
}
