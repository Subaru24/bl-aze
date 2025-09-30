extends Node2D

@onready var maze = []
@onready var tilemapLayer = $MazeTile

const WALL = Vector2i(0,0)
const PATH = Vector2i(1,0)

const N = 1
const E = 2
const S = 4
const W = 8

var rowSize = 20
var colSize = 20

var cellWalls = {

N: Vector2(0,-1),
E: Vector2(1,0),
S: Vector2(0,1),
W: Vector2(-1,0)

}

var cellPos = Vector2(8,0)

#var cellWallsText = {
#
#N: Vector2(0,-1),
#E: Vector2(1,0),
#S: Vector2(0,1),
#W: Vector2(-1,0)
#
#}

#var textWallKeys = cellWallsText.values()

var direction = [
	[-2,0],
	[0,2],
	[2,0],
	[0,-2]
]


@onready var visited = []

func _ready() -> void:
	mazeInit(rowSize,colSize)
	maze[1][1] = 0
	generateMaze(1,1)
	displayMaze()



# Generate the grid of the Maze
func mazeInit(rows,cols): 
	for r in range(rows):
		rows = []
		for c in range(cols):
			rows.append(1)
		maze.append(rows)

# Shows the maze on screen
func displayMaze():
	for row in maze:
		print(row)

#func checkNeighbours(currentCell):
#	var neighbourList = []
#	for val in textWallKeys:
#		var dir = currentCell + val
#		if dir not in visited:
#			neighbourList.append(dir)
#	return neighbourList 

	
	

#func generateMaze(cell):
#	mazeInit(20,20)
#	var neighbourList = checkNeighbours(cell)
#	if neighbourList.size() > 0:
#		visited.append(cell)
#		var neighbour = neighbourList.pick_random()
#		maze[neighbour.x][neighbour.y] = 1
#		generateMaze(neighbour)
#	else:
#		return cell

# Actually create the final maze pattern
func generateMaze(currentRow,currentCol):
	direction.shuffle()
	for dir in direction:
		var dirRow = dir[0]
		var dirCol = dir[1]
		var newRow = dirRow + currentRow
		var newCol = dirCol + currentCol
		if newRow in range(1, rowSize - 1) and newCol in range(1, colSize - 1) and maze[newRow][newRow] == 1:
			maze[dirRow/2 + currentRow][dirCol/2 + currentCol] = 0
			maze[newRow][newCol] = 0
			generateMaze(newRow,newCol)
