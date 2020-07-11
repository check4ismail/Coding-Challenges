/*
	Baby names: Each year, the government releases a list of the 10000 most commonly used names and their 
	frequencies (the number of babies with that name). The only problem with this is that some names have
	multiple spellings. For example, "John" and "Jon" are essentially the same name but would be listed
	separately in the list. Given two lists, one of the names/frequencies and the other of pairs of equivalent
	names, write an algorithm to print a new list of the true frequency of each name. Note that if John and Jon 
	are synonyms, and Jon and Johnny are synonyms, then John and Johnny are synonyms. (It is transitive and symmetric).

	In the final list, any name can be used as the "real" name.

	Input: 
		Names: John (15), Jon (12), Chris (13), Kris (4), Christopher (19)
		Synonyms: (John,Jon), (John,Johnny), (Chris,Kris), (Chris,Christopher)

	Output: John (27), Kris (36)

	NOTE: This solution utilizes a few data structures. With that said, here's how to run this coding challenge using Terminal:
	1) swiftc -o main BabyNames.swift main.swift data-structures/custom-graph/AdjacentList.swift data-structures/Queue.swift data-structures/LinkedList.swift
	2) ./main
*/
import Foundation

func babyNames(_ names: String, _ synonyms: String) {
	// Split by commas, then store in respective arrays
	let names = names.components(separatedBy: ", ")
	let synonyms = synonyms.components(separatedBy: ", ")

	// Utilize graph and keep track of vertices
	var graph = AdjacencyList()
	var vertices: [Vertex] = []

	babyNamesCreateVertex(names, &vertices, &graph) // creates vertices in graph, updates vertices list
	babyNamesAddEdges(synonyms, &vertices, &graph)	// establishes relationship between vertices using synonyms


	var set: Set<Vertex> = []
	var finalList: [(String, Int)] = []
	// Sets up the final list
	for vertex in vertices {
		// Set keep track of vertices that have relationships already - that way finalList 
		// uses only one vertex to represent relationship with others
		if !set.contains(vertex) {
			let name = vertex.data.name
			var count = 0
			graph.breadthFirstSearch(from: vertex).forEach {
				set.insert($0)
				count += $0.data.count
			}
			finalList.append((name, count))		
		}
	}

	// Here's the final list!
	var str = ""
	finalList.forEach { str += "\($0.0) (\($0.1)) - " }
	print(str)
}

func babyNamesCreateVertex(_ names: [String], _ vertices: inout [Vertex], _ graph: inout AdjacencyList) {
	for name in names {
		let arr = name.components(separatedBy: " ")
		let name = arr[0]
		let number = Array(arr[1])
		if let parsedNumber = Int(String(number[1..<number.count-1])) {
			// create vertex for each name & number
			vertices.append(graph.createVertex(data: (name, parsedNumber)))
		}
	}
}

func babyNamesAddEdges(_ synonyms: [String], _ vertices: inout [Vertex], _ graph: inout AdjacencyList) {
	for synonym in synonyms {
		let arr =  synonym.components(separatedBy: ",")
		
		let firstNameArr = Array(arr[0])
		let firstName = String(firstNameArr[1...])
		// Get the vertex that has the first name
		let sourceVertex = getVertex(firstName, &vertices, &graph)

		let secondNameArr = Array(arr[1])
		let secondName = String(secondNameArr[0..<secondNameArr.count-1])
		// Get the vertex that contains the second name
		let destinationVertex = getVertex(secondName, &vertices, &graph)

		// At this point, create edges to establish relationships between vertices
		graph.addDirectedEdge(from: sourceVertex, to: destinationVertex, weight: nil)
	}
}

func getVertex(_ name: String, _ vertices: inout [Vertex], _ graph: inout AdjacencyList) -> Vertex {
	guard let vertex = vertices.first(where: { $0.data.name == name }) else {
		// In case the synonym isn't a part of the original list, create a vertex for it
		let vertex = graph.createVertex(data: (name, 0))
		vertices.append(vertex)
		return vertex 
	}
	return vertex
}

func main() {
	// Test Data
	let names: String = "John (15), Jon (12), Chris (13), Kris (4), Christopher (19)"
	let synonyms: String = "(John,Jon), (John,Johnny), (Chris,Kris), (Chris,Christopher)"
	
	print("Names: \(names)")
	print("Synonyms: \(synonyms)")
	babyNames(names, synonyms)
}