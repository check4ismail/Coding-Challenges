/*
	BiNode: Consider a simple data structure called BiNode, which has pointers to two other nodes:
	public class BiNode {
		public BiNode node1, node2;
		public int data;
	}

	The data structure BiNode could be used to represent both a binary tree (where node1 is the left node and node2
	is the right node) or a doubly linked list (where node1 is the previous node and node2 is the next node).

	Implement a method to convert a binary search tree (implemented with BiNode) into a doubly linked list.
	The values should be kept *in order* and the operation should be performed in place (that is, of the original data structure).

	To run this program, enter the following commands in Terminal:
	1) swiftc -o main BiNode.swift main.swift
	2) ./main
*/
import Foundation

// BiNode class using Swift
public class BiNode {
	public var node1: BiNode? // leftChild for BST or prev for LinkedList
	public var node2: BiNode? // rightChild for BST or next for LinkedList
	public var data: Int

	public init(node1: BiNode? = nil, node2: BiNode? = nil, data: Int) {
		self.node1 = node1
		self.node2 = node2
		self.data = data
	}

	// Traverse through nodes via in-order
	public func traverseInOrder(visit: (Int) -> Void) {
		node1?.traverseInOrder(visit: visit)
		visit(data)
		node2?.traverseInOrder(visit: visit)
	}
}

// Implement BstOrLinkedList
public struct BstOrLinkedList {
	private var root: BiNode?
	
	public init() {}

	public mutating func insert(_ value: Int) {
		root = insert(from: root, value: value)
	}

	//Recursive function to insert value into BST
	//BST Rules
	//1) if value less than current node value, must be inserted into left child (node1)
	//2) if value greater than or equal to node value, must be inserted into right child (node2)
	private func insert(from node: BiNode?, value: Int) -> BiNode {
		guard let node = node else {
			return BiNode(data: value)
		}
		if value < node.data {
			node.node1 = insert(from: node.node1, value: value)
		} else {
			node.node2 = insert(from: node.node2, value: value)
		}

		return node
	}

	public mutating func toLinkedList() {
		root?.node1 = leftRotateAll(currentNode: root?.node1)		// left rotate entire left side of BST
		root?.node2 = rightRotateAll(currentNode: root?.node2)		// right rotate entire right side of BST
		
		root = rightOfBSTtoLinkedList(currentNode: root?.node2, prev: root)	// right side of tree already has next(node2) values, so setting prev values
		root = leftOfBSTtoLinkedList(currentNode: root?.node1, next: root)	// left side of tree already has prev(node1) values, so setting next values
		
		while let left = root?.node1 {	// Set root to first element of LinkedList (left most value)
			root = left
		}
	}
	
	private func leftRotateAll(currentNode: BiNode?) -> BiNode? {
		guard let node = currentNode else {
			return currentNode
		}
		node.node1 = leftRotateAll(currentNode: node.node1)
		guard let pivot = node.node2 else {	// if there's no right node, return current node
			return node
		}
		node.node2 = pivot.node1	// current right node is nil
		pivot.node1 = node			// right node is now parent of left nodes
		return pivot
	}
	
	private func rightRotateAll(currentNode: BiNode?) -> BiNode? {
		guard let node = currentNode else {
			return currentNode
		}
		node.node2 = rightRotateAll(currentNode: node.node2)
		guard let pivot = node.node1 else {	// if there's no left node, return current node
			return node
		}
		node.node1 = pivot.node2	// current right node is nil
		pivot.node2 = node			// left node is now parent of right nodes
		return pivot
	}
	
	// After right rotating right side of BST, all elements are like this:
	// 7 -> 8 -> 9 -> etc
	// node2 (next) is already set, but for a Doubly Linked List we need to set node1 (prev) for the rest
	// of right nodes
	private func rightOfBSTtoLinkedList(currentNode: BiNode?, prev: BiNode?) -> BiNode? {
		guard let node = currentNode else {
			return currentNode
		}
		node.node2 = rightOfBSTtoLinkedList(currentNode: node.node2, prev: node)
		node.node1 = prev	// Set node1 of node to prev
		return node
	}
	
	// After left rotating left side of BST, all elements are like this:
	// 1 <- 2 <- 3 <- etc
	// node1 (prev) is already set, but for a Doubly Linked List we need to set node2 (next) for the rest
	// of left nodes
	private func leftOfBSTtoLinkedList(currentNode: BiNode?, next: BiNode?) -> BiNode? {
		guard let node = currentNode else {
			return currentNode
		}
		node.node1 = leftOfBSTtoLinkedList(currentNode: node.node1, next: node)
		node.node2 = next	// Set node2 of node to next
		return node
	}

	// Traverse through Doubly LinkedList, then print all nodes
	public func traverseDoublyLinkedList() {
		var nodeCount = 1
		var current = root
		var str = "Traverse Linked List\n"
		
		while current != nil {
			str += "Node \(nodeCount)\n"
			if let previous = current?.node1 {
				str += "node1 (prev) - \(previous.data)\n"
			}
			str += "Current node data - \(current!.data)\n"
			if let next = current?.node2 {
				str += "node2 (next) - \(next.data)\n"
			}

			current = current!.node2 
			str += "\n"

			nodeCount += 1
		}

		print(str)
	}

	// Print out values of BST via in-order traversal
	public func traverseTreeInOrder() {
		guard let current = root else {
			return
		}
		var str = ""
		current.traverseInOrder { data in
			str += "-> \(data) "
		}
		print("Elements from binary tree")
		print(str)
		print("\n")
	}
}

func main() {
	var tree = BstOrLinkedList()
	// root node
	tree.insert(6)
	
	// all left
	tree.insert(4)
	tree.insert(5)
	tree.insert(2)
	tree.insert(1)
	tree.insert(3)

	// all right
	tree.insert(9)
	tree.insert(7)
	tree.insert(11)
	tree.insert(10)
	tree.insert(12)

	tree.traverseTreeInOrder() // prints tree
	tree.toLinkedList() // converts to doubly linked list
	tree.traverseDoublyLinkedList() // traverses through doubly linked list nodes
}
