extends Node

var timeElasped := 0
@onready var pauseMenu = $Control/PauseMenu
var isPaused = Globals.pauseState


func  _ready() -> void:
	$Control/Timer.start()
	$Control/Level.text = "LEVEL:" + str(Globals.levelNum)
	if Globals.pauseState:
		onPause()
	else:
		onUnpause()



func _on_timer_timeout():
	timeElasped += 1
	var minutes = int(timeElasped / 60)
	var seconds = timeElasped % 60 # Used mod instead because it made more sense
	$Control/Stopwatch.text = '%02d:%02d' % [minutes, seconds]
	# %02d means add exactly 2 digits, add a 0 if needed with these variables


func onPause():
	pauseMenu.show()
	get_tree().paused = true
	Globals.pauseState = true
	
func onUnpause():
	pauseMenu.hide()
	get_tree().paused = false
	Globals.pauseState = false
	
#func onOptionsPressed():
	#Globals.prevScene = get_tree().current_scene.scene_file_path
	##print(Globals.prevScene)
	#pauseMenu.hide()
	
	#Globals.pushSceneStack("res://Scenes/Options.tscn")
	
	
	
	
