extends Control

# ColorRect Nodes
@onready var mute = $"Variables/VolGrid/Mute"
@onready var twentyBar = $"Variables/VolGrid/20"
@onready var fourtyBar = $"Variables/VolGrid/40"
@onready var sixtyBar = $"Variables/VolGrid/60"
@onready var eightyBar = $"Variables/VolGrid/80"
@onready var hundredBar = $"Variables/VolGrid/100"
# Volume Array
@onready var nodeArr = [twentyBar,fourtyBar,sixtyBar,eightyBar,hundredBar]
#AudioServer.get_bus_index("Master")
@onready var master = AudioServer.get_bus_index("Master") #Able to use the "Master" volume index


const USERPATH = "user://user-options.cfg"
# user:// -> $HOME/.local/share/godot/app_userdata/'ProjectMaze'

@onready var toggleMinimap = $Variables/Minimap


func _ready() -> void:
	#print(Time.get_datetime_string_from_system())
	loadOptions()

func checkVol(rectArr):
	var index = 0
	if not rectArr:
		mute.button_pressed = true
		rectArr = [false,false,false,false,false]
	else:
		mute.button_pressed = false


	for rect in rectArr:
		if rect == false:
			nodeArr[index].button_pressed = false
		else:
			nodeArr[index].button_pressed = true
		index += 1
	
func _process(_delta):
	if Input.is_action_just_pressed("goBack"):
		_on_back_pressed()

func _on_20_pressed() -> void:
	print("20%")
	var locRectArr = [true,false,false,false,false] 
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.2) # Sets the volume to 20%
	print(str(AudioServer.get_bus_volume_linear(master) * 100) + "%")

func _on_40_pressed() -> void:
	print("40%")
	var locRectArr = [true,true,false,false,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.4)
	print(str(AudioServer.get_bus_volume_linear(master) * 100) + "%")

func _on_60_pressed() -> void:
	print("60%")
	var locRectArr = [true,true,true,false,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.6)
	print(str(AudioServer.get_bus_volume_linear(master) * 100) + "%")

func _on_80_pressed() -> void:
	print("80%")
	var locRectArr = [true,true,true,true,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.8)
	print(str(AudioServer.get_bus_volume_linear(master) * 100) + "%")

func _on_100_pressed() -> void:
	print("100%")
	var locRectArr = [true,true,true,true,true]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 1)
	print(str(AudioServer.get_bus_volume_linear(master) * 100) + "%")

func _on_back_pressed() -> void:
	saveOptions()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	
func saveOptions():
	var options = ConfigFile.new() 
	var volInt = int(AudioServer.get_bus_volume_linear(master) * 100)
	# Gets the current volume (from 0 - 1), 
	# converts it to a 0 - 100 number and removes the decimal
	options.set_value("User","Volume",volInt)
	options.set_value("User","Minimap",toggleMinimap.button_pressed)
	options.save(USERPATH) # Saves to config file

func loadOptions():
	var options = ConfigFile.new()
	options.load(USERPATH)
	var vol = options.get_value("User","Volume", 100)
	if typeof(vol) != TYPE_INT or vol < 0 or vol > 100:
		vol = 100
	# 100 = default value if not loaded correctly
	var volCall = "_on_%s_pressed" % vol 
	# the %s is replaced by whatever the "vol" is 
	call(volCall)
	# calls the function with the corresponding name 
	var mmap =  options.get_value("User","Minimap", true)
	if typeof(mmap) != TYPE_BOOL:
		mmap = true
	toggleMinimap.button_pressed = mmap

	


func _on_0_pressed() -> void:
	var locRectArr = false
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0)
