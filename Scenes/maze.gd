extends Node2D

@onready var maze = []
@onready var tilemapLayer = $MazeTile

const WALL = Vector2i(1,0)
const PATH = Vector2i(0,0)
const DEADEND = Vector2i(2,0)

var rowSize = 30
var colSize = 30
var cellSize = 20




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




func _ready() -> void:
	mazeInit()
	maze[1][1] = 0
	generateMaze()
	_draw()
	deadEnd()
	displayMaze()



# Generate the grid of the Maze
func mazeInit(): 
	for r in range(rowSize):
		var row = []
		for c in range(colSize):
			row.append(1)
		maze.append(row)

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
func generateMaze():
	mazeInit()
	var startrow = 1
	var startcol = 1
	maze[startrow][startcol] = 0
	makePath(startrow,startcol)

func makePath(currentRow,currentCol):
	direction.shuffle()
	for dir in direction:
		var dirRow = dir[0]
		var dirCol = dir[1]
		var newRow = dirRow + currentRow
		var newCol = dirCol + currentCol
		if newRow in range(1, rowSize - 1) and newCol in range(1, colSize - 1) and maze[newRow][newCol] == 1:
			maze[dirRow/2 + currentRow][dirCol/2 + currentCol] = 0
			maze[newRow][newCol] = 0
			makePath(newRow,newCol)
			

func _draw():
	tilemapLayer.clear()
	
	# Draw the maze
	for rows in range(rowSize):
		for cols in range(colSize):
			var tile = WALL if maze[rows][cols] == 1 else PATH if maze[rows][cols] == 0 else DEADEND
			tilemapLayer.set_cell(Vector2i(cols,rows),3,tile)

func deadEnd():
	var deadEnds = []
	for row in range(rowSize):
		for col in range(colSize):
			if maze[row][col] == 1:
				continue

			var neighbour = 0
			var possibleDirs = [
					[0,1],
					[1,0],
					[0,-1],
					[-1,0]
			]

			for dir in possibleDirs:
				var dirRow = dir[0]
				var dirCol = dir[1]
				var newRow = row + dirRow
				var newCol = col + dirCol
				if (0 <= newRow and newRow < len(maze) and 0 <= newCol and newCol < len(maze[0]) and maze[newRow][newCol] == 0):
					neighbour+=1

			if neighbour == 1:
				deadEnds.append([row,col])
	print(deadEnds)
	fillDeadEnds(deadEnds)

func fillDeadEnds(deadEnds):
	for coords in deadEnds:
		var x = coords[0]
		var y = coords[1]
		maze[x][y] = 4
