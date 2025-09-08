extends Node2D

@onready var maze = []

const N = 1
const E = 2
const S = 4
const W = 8

var cellWalls = {

N: Vector2(0,-1),
E: Vector2(1,0),
S: Vector2(0,1),
W: Vector2(-1,0)

}

var cellPos = Vector2(8,0)

var cellWallsText = {

N: Vector2(0,-1),
E: Vector2(1,0),
S: Vector2(0,1),
W: Vector2(-1,0)

}

var textWallKeys = cellWallsText.values()

@onready var visited = []

func _ready() -> void:
	mazeInit(10,10)
	# maze[newPos.y][newPos.x] = 10 # x and y are swapped cuz idek
	generateMaze(cellPos)
	displayMaze()


# Generate the grid of the Maze
func mazeInit(rows,cols): 
	for r in range(rows):
		rows = []
		for c in range(cols):
			rows.append(0)
		maze.append(rows)

# Shows the maze on screen
func displayMaze():
	for row in maze:
		print(row)

func checkNeighbours(currentCell):
	var neighbourList = []
	for val in textWallKeys:
		var dir = currentCell + val
		if dir not in visited:
			neighbourList.append(dir)
	return neighbourList 

	
	

# Actually create the final maze pattern
func generateMaze(cell):
	var neighbourList = checkNeighbours(cell)
	if neighbourList.size() > 0:
		visited.append(cell)
		var neighbour = neighbourList.pick_random()
		maze[neighbour.x][neighbour.y] = 1
		generateMaze(neighbour)
	else:
		return cell

	
