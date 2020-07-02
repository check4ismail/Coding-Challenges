// Doubly Linked List implementation
class Node<T> {
	weak var prev: Node?
	var next: Node?
	var value: T

	init(prev: Node? = nil, next: Node? = nil, value: T) {
		self.prev = prev
		self.next = next
		self.value = value
	}
}

public struct LinkedList<T> {
	private var head: Node<T>?
	private var tail: Node<T>?

	public var isEmpty: Bool {
		head == nil
	}

	public var first: T? {
		head?.value
	}

	public var last: T? {
		tail?.value
	}

	public init() {}

	private mutating func copyNodes() {
		guard !isKnownUniquelyReferenced(&head) else {
			return
		}
		guard var oldNode = head else {
			return
		}

		head = Node(value: oldNode.value)
		var newNode = head
		while let nextOldNode = oldNode.next {
			newNode!.next = Node(value: nextOldNode.value)
			newNode!.next!.prev = newNode
			newNode = newNode!.next
			oldNode = nextOldNode
		}
		tail = newNode
	}

	public mutating func push(_ value: T) {
		copyNodes()
		head = Node(next: head, value: value)
		head?.next?.prev = head
		if tail == nil {
			tail = head
		}
	}

	public mutating func append(_ value: T) {
		guard !isEmpty else {
			push(value)
			return
		}
		copyNodes()
		tail?.next = Node(prev: tail, value: value)
		tail = tail!.next
	}

	@discardableResult
	public mutating func pop() -> T? {
		defer {
			head = head?.next
			head?.prev = nil
			if head == nil {
				tail = nil
			}
		}
		return head?.value
	}

	@discardableResult
	public mutating func removeLast() -> T? {
		defer {
			tail = tail?.prev
			tail?.next = nil
			if tail == nil {
				head = nil
			}
		}
		return tail?.value
	}
}