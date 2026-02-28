extends Node

var timeElasped: = 0
@onready var pauseMenu = $Control / PauseMenu
var isPaused = Globals.pauseState


func _ready() -> void :
    $Control / Timer.start()
    $Control / Level.text = "LEVEL:" + str(Globals.levelNum)
    $Control / Points.text = "POINTS:" + str(Globals.totalPoints)
    if Globals.pauseState:
        onPause()
    else:
        onUnpause()



func _on_timer_timeout():
    timeElasped += 1
    var minutes = int(timeElasped / 60)
    var seconds = timeElasped % 60
    $Control / Stopwatch.text = "%02d:%02d" % [minutes, seconds]



func onPause():
    pauseMenu.show()
    get_tree().paused = true
    Globals.pauseState = true

func onUnpause():
    pauseMenu.hide()
    get_tree().paused = false
    Globals.pauseState = false













func _on_maze_tree_exited() -> void :
    Globals.levelTime = timeElasped
    Globals.totalTime += timeElasped
