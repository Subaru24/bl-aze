extends Button

func _ready() -> void:
	var volume20 = get_node("Variables/VolGrid/20")
	volume20.pressed.connect(
		func twentyPercent():
			print("20%")
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(-20))
			)
		

#func volumeControl():
#	if $"Variables/VolGrid/20".is_pressed():
#		modulate.$Variables/VolGrid/ColorRect5 = 100
	
