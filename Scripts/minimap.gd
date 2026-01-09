extends SubViewport

@export var playerNode: Node2D
@export var cameraNode: Node2D
# Exports the variables to the inspector in Godot

func _ready() -> void:
	var isMinimap = Globals.loadMinimap()
	if not isMinimap:
		$"..".hide()

		
			

func _process(_delta:float) -> void:
	cameraNode.position = playerNode.position
