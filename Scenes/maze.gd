extends Node2D

var maze = []
@onready var tilemapLayer = $MazeTile



const PATH = Vector2i(0,0)
const WALL = Vector2i(1,0)
const END = Vector2i(2,0)
const START = Vector2i(3,0)

var rowSize = Globals.rowSize
var colSize = Globals.colSize
var coords = Globals.coords


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
	print(rowSize)
	print(colSize)
	print(coords)


	var startRow = coords[0]
	var startCol = coords[1]	
	mazeInit()
	print(maze)
	maze[startRow][startCol] = 0
	generateMaze(startRow,startCol)
	deadEnd()
	_draw()
	#shortestPathBFS(Globals.startPos,Globals.endPos)
	displayMaze()
	


# Generate the grid of the Maze
func mazeInit(): 
	maze.clear()
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


#	var bpp = shortestPathBFS(Globals.startPos,Globals.endPos)
#	for til in bpp:
#		tilemapLayer.set_cell(Vector2i(til[1],til[0]),3,START)
		



func deadEnd():
	var deadEnds = []
	for row in range(rowSize):
		for col in range(colSize):
			if maze[row][col] == 1:  #Skips cell if it's a wall
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
				if (0 <= newRow and newRow < len(maze) and 0 <= newCol and newCol < len(maze[0]) and maze[newRow][newCol] == 0): #Checks the bounds of the maze
					neighbour+=1

			if neighbour == 1:  #If there is only one neighbour, it's a dead end
				deadEnds.append([row,col])
	print(deadEnds)
	chooseStartandEnd(deadEnds)

func chooseStartandEnd(deadEnds):
	var pickEnds = 0
	var start = deadEnds.pick_random()
	var end = 0 
	var arrPos = deadEnds.find(start)
	# var poppedVal = deadEnds.pop_at(arrPos)
	var mid = len(deadEnds) / 2
	if arrPos > mid:
		pickEnds = deadEnds.slice(0,6) # Splices list from index 0 to 5
	elif arrPos <= mid:
		pickEnds = deadEnds.slice(-5,len(deadEnds))
	# Emulating a do-until loop 
	while true:   
		end = pickEnds.pick_random()
		if end != start:
			break
		else:
			var i = pickEnds.find(end)
			pickEnds.remove_at(i)
	
	maze[end[0]][end[1]] = 2
	maze[start[0]][start[1]] = 3
	# Setting the coords of the points to Vector2i
	var startingTile = Vector2i(start[1],start[0])
	var endingTile = Vector2i(end[1],end[0])
	
	# Sets the the position to the globals  
	Globals.startPosTile = tilemapLayer.map_to_local(startingTile)
	Globals.startPos = start
	Globals.endPos = end
	# Defining the Area's position to the end tile
	var endPosTile = tilemapLayer.map_to_local(endingTile)
	$Area2D.global_position = tilemapLayer.to_global(endPosTile)
	


func shortestPathBFS(start,end):
	var solution = [] # List for the path 
	var queue = [] # Queue for subsequent nodes
	var visited = {} # Check if node is visited (Dict for O(1) lookup)
	var parent = {} # Key = child, Value = parent
	

	queue.append(start)
	visited[start] = true
	parent[start] = null # null as it's the root node
	
	while len(queue) != 0:
		var selectedNode = queue.pop_front()
		if selectedNode == end:
			while selectedNode != null:
				solution.insert(0,selectedNode) # Adds nodes backwards
				selectedNode = parent[selectedNode]
			#print(solution)
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
				
		



	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Scenes/Level-End.tscn")



	
	

	
