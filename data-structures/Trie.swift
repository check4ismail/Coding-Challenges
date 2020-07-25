class TrieNode<Key: Hashable> {
	var key: Key?
	weak var parent: TrieNode?
	var children: [Key: TrieNode] = [:]
	var isTerminating = false
	
	init(key: Key?, parent: TrieNode?) {
		self.key = key
		self.parent = parent
	}
}

public class Trie<CollectionType: Collection> where CollectionType.Element:Hashable {
	typealias Node = TrieNode<CollectionType.Element>
	private var root = Node(key: nil, parent: nil)
	
	public init(){}
	
	public func insert(_ collection: CollectionType) {
		var current = root
		for element in collection {
			if current.children[element] == nil {
				current.children[element] = Node(key: element, parent: current)
			}
			current = current.children[element]!
		}
		current.isTerminating = true
	}
	
	public func contains(_ collection: CollectionType) -> Bool {
		var current = root
		for element in collection {
			guard let child = current.children[element] else {
				return false
			}
			current = child
		}
		return current.isTerminating
	}
	
	// Checks to see if TrieNodes for collection do exist without checking
	// isTerminating value
	public func potentialContains(_ collection: CollectionType) -> Bool {
		var current = root
		for element in collection {
			guard let child = current.children[element] else {
				return false
			}
			current = child
		}
		return true
	}
	
	public func remove(_ collection: CollectionType) {
		var current = root
		for element in collection {
			guard let child = current.children[element] else {
				return
			}
			current = child
		}
		guard current.isTerminating else { return }
		current.isTerminating = false
		
		while let parent = current.parent, !current.isTerminating &&
			current.children.isEmpty {
			parent.children[current.key!] = nil
			current = parent
		}
	}
}

extension Trie where CollectionType:RangeReplaceableCollection {
	public func collection(startingWith prefix: CollectionType) -> [CollectionType] {
		var current = root
		for element in prefix {
			guard let child = current.children[element] else {
				return []
			}
			current = child
		}
		return collection(startingWith: prefix, after: current)
	}
	
	private func collection(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
		var results: [CollectionType] = []
		if node.isTerminating {
			results.append(prefix)
		}
		
		for child in node.children.values {
			var prefix = prefix
			prefix.append(child.key!)
			results.append(contentsOf: collection(startingWith: prefix, after: child))
		}
		return results
	}
}
