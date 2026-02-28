extends Control



func _ready() -> void :
    var completed = $CompleteMessage
    var pointsGot = $Points
    var points = pointCalc(Globals.levelPoints)
    completed.text = "LEVEL " + str(Globals.levelNum) + " COMPLETED"
    pointsGot.text = "YOU GOT " + str(points) + " POINTS"

func _on_texture_button_pressed() -> void :
    Globals.levelNum += 1
    get_tree().change_scene_to_file("res://Scenes/LevelManage.tscn")

func pointCalc(points):
    var timeTaken = Globals.levelTime
    var totalPoints = points - (timeTaken / 2)
    Globals.totalPoints += totalPoints
    return totalPoints
