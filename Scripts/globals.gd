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

var levelNum: int = 5

var rowSize: int = 20
var colSize: int = 20

var coords = [1,1]

var sceneStack: Array[Node] = []

const USERPATH = "user://user-options.cfg"


func pushSceneStack(newScenePath):
	var currentScene = get_tree().current_scene 
	currentScene.visible = false
	sceneStack.append(currentScene)

	var newScene = load(newScenePath).instantiate()
	get_tree().root.add_child(newScene) # Adds node to tree
	get_tree().current_scene = newScene # Parameter node displayed on screen


func popSceneStack():
	var currentScene = get_tree().current_scene 
	currentScene.queue_free() # Remove the node from the tree

	var previous = sceneStack.pop_back() # Pops the previous node out stack
	previous.visible = true
	get_tree().current_scene = previous # Previous scene becomes current


#func checkPrev(previousScene):
	#var scene = get_tree().current_scene
	#print(scene)
	#if scene is CanvasItem:
		#scene.hide()
	#else: 
		#get_tree().change_scene_to_file(previousScene)
func loadMinimap():
	var options = ConfigFile.new()
	options.load(USERPATH)
	var mmap =  options.get_value("User","Minimap", true)
	if typeof(mmap) != TYPE_BOOL:
		mmap = true
	return mmap
