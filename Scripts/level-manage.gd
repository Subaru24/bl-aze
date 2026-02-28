extends Control


func _ready():
    var isMazeLevel = checkLevel(Globals.levelNum)
    if isMazeLevel:
        get_tree().change_scene_to_file("res://Scenes/Maze.tscn")
    else:
        get_tree().change_scene_to_file("res://Scenes/Round-End.tscn")


func checkLevel(levelNumber):
    if levelNumber <= 5:
        Globals.coords = [1, 1]
        Globals.rowSize = 20
        Globals.colSize = 20
        Globals.levelPoints = 500
        return true
    elif levelNumber <= 10:
        Globals.coords = [12, 12]
        Globals.rowSize = 25
        Globals.colSize = 25
        Globals.levelPoints = 650
        return true
    elif levelNumber <= 15:
        Globals.coords = [1, 1]
        Globals.rowSize = 30
        Globals.colSize = 30
        Globals.levelPoints = 700
        return true
    elif levelNumber <= 20:
        Globals.coords = [17, 17]
        Globals.rowSize = 35
        Globals.colSize = 35
        Globals.levelPoints = 800
        return true
    elif levelNumber > 20:
        return false
