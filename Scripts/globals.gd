extends Node
@onready var hud = get_tree().get_first_node_in_group("hud")

# Positions for text maze
var startPos 
var endPos
# Positions for tile maze
var startPosTile: Vector2
var endPosTile: Vector2

var prevScene = "res://Scenes/MainMenu.tscn"
var pauseState := false

var sceneStack: Array[Node]

func pushSceneStack(newScenePath):
	var currentScene = get_tree().get_first_node_in_group("hud")
	sceneStack.append(currentScene)
	currentScene.visible = false
	
	var newScene = load(newScenePath).instantiate()
	hud.add_child(newScene)
	
	
	

func popSceneStack():
	var currentScene = get_tree().current_scene
	currentScene.queue_free()
	var previous = sceneStack.pop_back()
	if not FileAccess.file_exists(previous):
		hud.remove_child(currentScene)
	else:
		get_tree().current_scene = previous
	previous.visible = true

var levelNum : int = 1
