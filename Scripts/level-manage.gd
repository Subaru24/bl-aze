extends Control


func _ready():
	checkLevel(Globals.levelNum)
	get_tree().change_scene_to_file("res://Scenes/Maze.tscn")

func checkLevel(levelNumber):
	if levelNumber <= 5:
		Globals.coords = [1,1]
		Globals.rowSize = 20
		Globals.colSize = 20
	elif levelNumber <= 10:
		Globals.coords = [12,12]
		Globals.rowSize = 25
		Globals.colSize = 25
	elif levelNumber <= 15:
		Globals.coords = [1,1]
		Globals.rowSize = 30
		Globals.colSize = 30
	elif levelNumber <= 20:
		Globals.coords = [12,12]
		Globals.rowSize = 35
		Globals.colSize = 35
	elif levelNumber > 20:
		get_tree().change_scene_to_file("res://Scenes/Round-End.tscn")

