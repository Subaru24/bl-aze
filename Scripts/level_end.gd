extends Control



func _ready() -> void:
	var label = $CompleteMessage
	label.text = "Level Completed"
	#label.text = "Level " + str(Globals.levelNum) + " Completed"

func _on_texture_button_pressed() -> void:
	Globals.levelNum += 1
	get_tree().change_scene_to_file("res://Scenes/LevelManage.tscn")
	
