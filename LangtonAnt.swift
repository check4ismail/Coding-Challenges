/*
	Question 22: Langton's Ant: An ant is sitting on an infinite grid of white and black squares.
	It initially faces right. At each step, it does the following:
	1. At a white square, flip the color of the square, turn clockwise, and move forward one unit
	2. At a black square, flip the color of the square, turn counter clockwise, and move forward one unit

	Write a program to simulate the first K moves that the ant makes and print the final board as a grid.
	Note that you are not provided with a data structure to represent the grid. This is something you
	must design yourself. The only input to your method is K. You should print the final grid and return nothing.

	The method signature might be something like void printKMoves(int k)
*/
enum Move {
	case up
	case right
	case down
	case left
}
struct Ant {
	init(){}
	var direction: Move = .right
	var (row, column): (Int, Int) = (0, 0)
	private var directions: [Move] = [.right, .down, .left, .up]
	private var indexDirection: Int = 0

	public mutating func clockWiseShift() {
		indexDirection += 1
		if indexDirection >= directions.count {
			indexDirection = 0
		}
		direction = directions[indexDirection]
	}

	public mutating func counterClockWiseShift() {
		indexDirection -= 1
		if indexDirection < 0 {
			indexDirection = directions.count - 1
		}
		direction = directions[indexDirection]
	}
	
	public mutating func rowAndColumnCheck(rowSize: Int, colSize: Int) {
		if row < 0 {
			row = rowSize - 1
		} else if row >= rowSize {
			row = 0
		}
		
		if column < 0 {
			column = colSize - 1
		} else if column >= colSize {
			column = 0
		}
	}
}
private func printKMoves(k: Int) {
	var ant = Ant()
	var grid: [[String]] = Array(repeating: [], count: 20)
	let gridValues: [String] = ["W", "B"]
	// Creating 20 by 20 random grid of Ws and Bs
	for i in 0..<grid.count {
		for _ in 0..<grid.count {
			grid[i].append(gridValues.randomElement()!)
		}
	}
	print("Before \(k) moves")
	printAntInGrid(ant, grid)
	print("\n")
	printKMoves(&ant, &grid, 0, k)
}
private func printKMoves(_ ant: inout Ant, _ grid: inout [[String]], _ current: Int, _ k: Int) {
	guard current < k else {
		printAntInGrid(ant, grid)
		return
	}
	if grid[ant.row][ant.column] == "B" {
		grid[ant.row][ant.column] = "W"
		ant.counterClockWiseShift()
	} else {
		grid[ant.row][ant.column] = "B"
		ant.clockWiseShift()
	}

	switch ant.direction {
		case .right:
			ant.column += 1
		case .down:
			ant.row += 1
		case .left:
			ant.column -= 1
		case .up:
			ant.row -= 1
	}
	ant.rowAndColumnCheck(rowSize: grid.count, colSize: grid[0].count)
	printKMoves(&ant, &grid, current + 1, k)
}
private func printAntInGrid(_ ant: Ant, _ grid: [[String]]) {
	var grid = grid
	grid[ant.row][ant.column] += "-A"
	for i in 0..<grid.count {
		var strRow = ""
		for j in 0..<grid[i].count {
			strRow += "| \(grid[i][j])\t"
		}
		print(strRow)
	}
}

// Call function to test solution
printKMoves(k: 2)
