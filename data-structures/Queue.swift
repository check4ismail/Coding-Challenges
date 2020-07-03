// Basic Queue
public struct Queue<T> {
	private var elements = LinkedList<T>()

	public init(){}

	public var isEmpty: Bool {
		elements.isEmpty
	}

	public func peek() -> T? {
		return elements.first
	}

	public mutating func enqueue(_ value: T) {
		elements.append(value)
	}

	public mutating func dequeue() -> T? {
		return elements.pop()
	}
}

// Double-ended queue
public struct DoubleEndedQueue<T> {
	private var elements = LinkedList<T>()

	public init() {}

	public var count: Int {
		elements.count
	}
	
	public func peekFront() -> T? {
		return elements.first
	}

	public func peekRear() -> T? {
		return elements.last
	}

	public mutating func enqueueFront(_ value: T) {
		elements.push(value)
	}

	public mutating func enqueueRear(_ value: T) {
		elements.append(value)
	}

	public mutating func dequeueFront() -> T? {
		return elements.pop()
	}

	public mutating func dequeueRear() -> T? {
		return elements.removeLast()
	}
}