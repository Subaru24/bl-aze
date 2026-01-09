extends Control


func _ready():
	var isMazeLevel = checkLevel(Globals.levelNum)
	if isMazeLevel:
		get_tree().change_scene_to_file("res://Scenes/Maze.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Round-End.tscn") # Scene at end of game

# Every 5 levels the maze gets bigger by 5x5 starting at 20x20
func checkLevel(levelNumber):
	if levelNumber <= 5:
		Globals.coords = [1,1]
		Globals.rowSize = 20
		Globals.colSize = 20
		return true
	elif levelNumber <= 10:
		Globals.coords = [12,12] # On levels 6-10 & 16-20 have the maze generated in reverse
		Globals.rowSize = 25
		Globals.colSize = 25
		return true
	elif levelNumber <= 15:
		Globals.coords = [1,1]
		Globals.rowSize = 30
		Globals.colSize = 30
		return true
	elif levelNumber <= 20:
		Globals.coords = [-1,-1]
		Globals.rowSize = 35
		Globals.colSize = 35
		return true
	elif levelNumber > 20:
		return false # false is return as this is past the level limit
