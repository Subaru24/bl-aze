extends Control
func _ready() -> void:
	$HBoxContainerd/Start.grab_focus() # Focuses the start button for easier access 

#func _on_start_pressed():
#	get_tree().change_scene_to_file("res://Scenes/Game.tscn") # Go to the Main Game
#
#
#func _on_options_pressed() -> void:
#	get_tree().change_scene_to_file("res://Scenes/Options.tscn") # Opens Options
#
#
#func _on_quit_pressed() -> void:
#	get_tree().quit() # Closes the program
#

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn") # Go to the Main Game

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Options.tscn") # Opens Options


func _on_score_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Score-Table.tscn") # Opens Options

func _on_quit_pressed() -> void:
	get_tree().quit() # Closes the program

