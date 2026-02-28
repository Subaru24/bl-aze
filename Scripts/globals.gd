extends Node

@onready var hud = get_tree().get_first_node_in_group("hud")


var startPos
var endPos

var startPosTile: Vector2
var endPosTile: Vector2

var prevScene = "res://Scenes/MainMenu.tscn"
var pauseState: = false

var levelNum: int = 1

var levelPoints: = 500
var totalPoints: = 0

var levelTime: = 0
var totalTime: = 0

var rowSize: int = 20
var colSize: int = 20

var coords = [1, 1]

var sceneStack: Array[Node] = []

const USERPATH = "user://user-options.cfg"

var scoreState: = "date"


func pushSceneStack(newScenePath):
    var currentScene = get_tree().current_scene
    currentScene.visible = false
    sceneStack.append(currentScene)

    var newScene = load(newScenePath).instantiate()
    get_tree().root.add_child(newScene)
    get_tree().current_scene = newScene


func popSceneStack():
    var currentScene = get_tree().current_scene
    currentScene.queue_free()

    var previous = sceneStack.pop_back()
    previous.visible = true
    get_tree().current_scene = previous










func loadMinimap():
    var options = ConfigFile.new()
    options.load(USERPATH)
    var mmap = options.get_value("User", "Minimap", true)
    if typeof(mmap) != TYPE_BOOL:
        mmap = true
    return mmap
