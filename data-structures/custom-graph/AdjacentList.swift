/*
	In order to solve BabyNames problem, created a specialized graph adjacency list 
	that has a vertex with tuple values - the name and count
*/
import Foundation 

public struct Vertex: Equatable, Hashable, CustomStringConvertible {
	let index: Int
	let data: (name: String, count: Int)

	public var description: String { "\(data)" }

	
	public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
		return lhs.data.name == rhs.data.name 
	}
	
	public func hash(into hasher: inout Hasher) {
        hasher.combine(data.name)
        hasher.combine(data.count)
    }
}

public struct Edge: Hashable {
	let source: Vertex
	let destination: Vertex
	let weight: Double?
}

public class AdjacencyList {
	private var adjacencies: [Vertex: [Edge]] = [:]

	public init(){}

	public func createVertex(data: (String, Int)) -> Vertex {
		let vertex = Vertex(index: adjacencies.count, data: data)
		adjacencies[vertex] = []

		return vertex
	}	

	public func edges(from source: Vertex) -> [Edge] {
		return adjacencies[source] ?? []
	}

	public func addDirectedEdge(from source: Vertex, to destination: Vertex, weight: Double?) {
		adjacencies[source]?.append(Edge(source: source, destination: destination, weight: weight))
	}

	public func breadthFirstSearch(from start: Vertex) -> [Vertex] {
		var queue = Queue<Vertex>()
		var enqueued: Set<Vertex> = []
		var visited: [Vertex] = []

		queue.enqueue(start)
		enqueued.insert(start)

		while let vertex = queue.dequeue() {
			visited.append(vertex)

			let neighbors = edges(from: vertex)
			neighbors.forEach{ edge in
				if !enqueued.contains(edge.destination) {
					queue.enqueue(edge.destination)
					enqueued.insert(edge.destination)
				}
			}
		}

		return visited
	}
}