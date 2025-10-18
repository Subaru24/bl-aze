extends CharacterBody2D

func _ready() -> void:
	await get_tree().process_frame
	global_position = Globals.startPosTile
	print(Globals.startPos)
	print(Globals.endPos)


func _physics_process(_delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("moveUp"):
		velocity.y = -1
	if Input.is_action_pressed("moveDown"):
		velocity.y = 1
	if Input.is_action_pressed("moveLeft"):
		velocity.x = -1
	if Input.is_action_pressed("moveRight"):
		velocity.x = 1
