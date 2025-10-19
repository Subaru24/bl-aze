extends Node2D

@onready var maze = []
@onready var tilemapLayer = $MazeTile

const PATH = Vector2i(0,0)
const WALL = Vector2i(1,0)
const END = Vector2i(2,0)
const START = Vector2i(3,0)

var rowSize = 15
var colSize = 15
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
	generateMaze(1,1)
	deadEnd()
	_draw()
	#shortestPathBFS(Globals.startPos,Globals.endPos)
	#displayMaze()



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
func generateMaze(currentRow,currentCol):
	direction.shuffle()
	for dir in direction:
		var dirRow = dir[0]
		var dirCol = dir[1]
		var newRow = dirRow + currentRow
		var newCol = dirCol + currentCol
		if newRow > 0 and newRow < rowSize - 1 and newCol > 0 and newCol < colSize - 1  and maze[newRow][newCol] == 1:
			maze[dirRow/2 + currentRow][dirCol/2 + currentCol] = 0
			maze[newRow][newCol] = 0
			generateMaze(newRow,newCol)
			

func _draw():
	tilemapLayer.clear()
	
	# Draw the maze
	for rows in range(rowSize):
		for cols in range(colSize):
			var tile = WALL if maze[rows][cols] == 1 else PATH if maze[rows][cols] == 0 else END if maze[rows][cols] == 2 else START
			tilemapLayer.set_cell(Vector2i(cols,rows),3,tile)
	#var bpp = shortestPathBFS(Globals.startPos,Globals.endPos)
	#for til in bpp:
	#	tilemapLayer.set_cell(Vector2i(til[1],til[0]),3,START)
		



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
	#print(deadEnds)
	chooseStartandEnd(deadEnds)

func chooseStartandEnd(deadEnds):
	var pickEnds = []
	var start = deadEnds.pick_random()
	var arrPos = deadEnds.find(start)
	var high = len(deadEnds) - 1
	var low = 0
	var mid = len(deadEnds) / 2
	if arrPos > mid:
		high = 5
		while high >= 0:
			pickEnds.append(deadEnds[high])
			high -= 1
	elif arrPos <= mid:
		low = -5
		while low <= 0:
			pickEnds.append(deadEnds[low])
			low += 1
	var end = pickEnds.pick_random()
	maze[end[0]][end[1]] = 2
	maze[start[0]][start[1]] = 3
	var startingTile = Vector2i(start[1],start[0])
	var endingTile = Vector2i(end[0],end[1])
	Globals.startPosTile = tilemapLayer.map_to_local(startingTile)
	Globals.startPos = start
	Globals.endPos = end
#	Globals.endPos = tilemapLayer.map_to_local(endingTile)


func shortestPathBFS(start,end):
	var solution = []
	var queue = []
	var visited = {}
	var parent = {}
	

	queue.append(start)
	visited[start] = true
	parent[start] = null
	
	while len(queue) != 0:
		var selectedNode = queue.pop_front()
		if selectedNode == end:
			while selectedNode != null:
				solution.insert(0,selectedNode)
				selectedNode = parent[selectedNode]
			print(solution)
			return solution

		var possibleDirs = [
					[0,1],
					[1,0],
					[0,-1],
					[-1,0]
			]

		for dir in possibleDirs:
			var dirRow = dir[0]
			var dirCol = dir[1]
			var newRow = selectedNode[0] + dirRow
			var newCol = selectedNode[1] + dirCol
			var coord = [newRow,newCol]
			if not visited.has(coord) and maze[newRow][newCol] != 1:
				queue.append(coord)
				visited[coord] = true
				parent[coord] = selectedNode
	

	#print(costs)
				
	
	
