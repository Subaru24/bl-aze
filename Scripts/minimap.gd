extends SubViewport

@export var playerNode: Node2D
@export var cameraNode: Node2D


func _ready() -> void :
    var isMinimap = Globals.loadMinimap()
    world_2d = get_tree().root.world_2d
    if not isMinimap:
        $"..".hide()




func _process(_delta: float) -> void :
    cameraNode.position = playerNode.position
