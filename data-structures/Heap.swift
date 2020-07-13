import Foundation 

public struct Heap <T: Equatable> {
	var elements: [T] = []
	let sort: (T, T) -> Bool

	public init(sort: @escaping (T,T) -> Bool) {
		self.sort = sort
	}

	public init(sort: @escaping (T,T) -> Bool, elements: [T]) {
		self.sort = sort
		self.elements = elements

		if !isEmpty {
			for i in stride(from: count / 2 - 1, through: 0, by: -1) {
				shiftDown(from: i)
			}
		}
	}

	public var count: Int { elements.count }
	
	public var isEmpty: Bool { elements.isEmpty }
	
	public func peek() -> T? {
		return elements.first
	}

	private func parentIndex(ofChildAt index: Int) -> Int {
		return (index - 1) / 2
	}

	private func leftChildIndex(ofParentAt index: Int) -> Int {
		return 2 * index + 1
	}

	private func rightChildIndex(ofParentAt index: Int) -> Int {
		return 2 * index + 2
	}

	public mutating func insert(_ element: T) {
		elements.append(element)
		shiftUp(from: count - 1)
	}

	public mutating func remove() -> T? {
		guard !isEmpty else { return nil }
		elements.swapAt(0, count - 1)
		defer {
			shiftDown(from: 0)
		}
		return elements.removeLast()
	}

	public mutating func remove(at index: Int) -> T? {
		guard index < count && !isEmpty else {
			return nil
		}

		if index == count - 1 {
			return elements.removeLast()
		} else {
			elements.swapAt(index, count - 1)
			defer {
				shiftDown(from: index)
				shiftUp(from: index)
			}
			return elements.removeLast()
		}
	}

	public func sorted() -> [T] {
		var heap = self
		for index in heap.elements.indices.reversed() {
			heap.elements.swapAt(0, index)
			heap.shiftDown(from: 0, limit: index)
		}
		return heap.elements
	}

	private mutating func shiftUp(from index: Int) {
		var child = index
		var parent = parentIndex(ofChildAt: child)
		while child > 0 && sort(elements[child], elements[parent]) {
			elements.swapAt(child, parent)
			child = parent
			parent = parentIndex(ofChildAt: child)
		}
	}

	private mutating func shiftDown(from index: Int) {
		var parent = index
		while true {
			var candidate = parent
			let left = leftChildIndex(ofParentAt: candidate)
			let right = rightChildIndex(ofParentAt: candidate)

			if left < count && sort(elements[left], elements[candidate]) {
				candidate = left
			}
			if right < count && sort(elements[right], elements[candidate]) {
				candidate = right
			}

			if candidate == parent {
				return
			}
			elements.swapAt(candidate, parent)
			parent = candidate
		}
	}

	private mutating func shiftDown(from index: Int, limit: Int) {
		var parent = index
		while true {
			var candidate = parent
			let left = leftChildIndex(ofParentAt: candidate)
			let right = rightChildIndex(ofParentAt: candidate)

			if left < limit && sort(elements[left], elements[candidate]) {
				candidate = left
			}
			if right < limit && sort(elements[right], elements[candidate]) {
				candidate = right
			}

			if candidate == parent {
				return
			}
			elements.swapAt(candidate, parent)
			parent = candidate
		}
	}
}



























