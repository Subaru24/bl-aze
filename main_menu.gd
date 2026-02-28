extends Control
func _ready() -> void :
    $HBoxContainerd / Start.grab_focus()













func _on_start_pressed():
    get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_options_pressed() -> void :
    Globals.prevScene = get_tree().current_scene.scene_file_path
    get_tree().change_scene_to_file("res://Scenes/Options.tscn")


func _on_score_pressed() -> void :
    get_tree().change_scene_to_file("res://Scenes/Score-Table.tscn")

func _on_quit_pressed() -> void :
    get_tree().quit()
