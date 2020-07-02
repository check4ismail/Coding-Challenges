/*
	LRU Cache: design and build a "least recently used" cache, which evicts the least recently used item.
	The cache should map from keys to values and can be initialized with a max size. When it is full, it 
	should evict the least recently used item.
*/
import Foundation

public struct LRUCache<Key: Hashable, Value> {
	private var cache: [Key: Value] = [:]
	private var queue = DoubleEndedQueue<Key>()
	private let capacity: Int

	public init(capacity: Int) {
		self.capacity = capacity
	}

	public mutating func queueTracker(_ key: Key, value: Value?) {
		guard let value = value else { return }
		if cache.count >= capacity {
			while let key = queue.dequeueRear() {
				if let _ = cache[key] {
					print("Removed key: \(key)")
					cache[key] = nil
					break
				}
			}
		}
		queue.enqueueFront(key)
		self.cache[key] = value
		print("After adding to queue")
		print("Front of queue: \(queue.peekFront())")
		print("Rear of queue: \(queue.peekRear())")
	}

	public subscript(key: Key) -> Value? {
		mutating get {
			queueTracker(key, value: cache[key])
			return cache[key]
		}
		set {
			if let value = newValue {
				queueTracker(key, value: value)
				cache[key] = value
			} else {
				cache[key] = nil
			}
		}
	}
}
extension LRUCache: CustomStringConvertible {
	public var description: String {
		var str = "Current count: \(cache.count)\n"
		for (key, value) in cache {  
			str += "\(key): \(value)\n"
		}
		return str
	}
}

func main() {
	// Testing LRU Cache
	var lruCache = LRUCache<String, String>(capacity: 5)

	for i in 1...5 {
		let random = Int.random(in: 1...100)
		lruCache["\(i)"] = "\(random)"
	}
	print(lruCache)

	lruCache["10"] = "New number - key 1 should be out!"
	print(lruCache)
	
	lruCache["11"] = "New number - key 2 should be out!"
	print(lruCache)

	lruCache["12"] = "New number - key 3 should be out!"
	print(lruCache)

	let _ = lruCache["4"] // Moves to front of queue because it's being used
	
	print("\nSetting 10 to nil")
	lruCache["10"] = nil

	print("\nTrying to use a nil value")
	let _ = lruCache["10"]

	print(lruCache)
}