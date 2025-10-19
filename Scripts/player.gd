extends CharacterBody2D

const speed := 100.0
var playerDir : Vector2

func _ready() -> void:
	await get_tree().process_frame
	var tilePos = Globals.startPosTile
	print(Globals.startPos)
	print(Globals.endPos)


func _physics_process(_delta):
	playerDir.x = Input.get_axis("moveLeft","moveRight")
	playerDir.y = Input.get_axis("moveUp","moveDown")
	
	if playerDir:
		velocity = playerDir * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO,speed)
	move_and_slide()
	
