extends Control

const USERPATH = "user://user-options.cfg" # Path of config file
@onready var map = $Sprite2D # The minimap



func _on_start_pressed() -> void:
	Globals.levelNum = 1
	get_tree().change_scene_to_file("res://Scenes/Maze.tscn")
	



func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func _ready() -> void:
	minimapCheck ()
	pass
	
func minimapCheck ():
	var options = ConfigFile.new()
	options.load(USERPATH)
	var isMinimap = options.get_value("User","Minimap",true)
	if isMinimap:
		map.visible = true
	else: 
		map.visible = false
		
	
	
