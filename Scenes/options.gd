extends Control
@onready var twentyBar = $"Variables/VolGrid/20Rect"
@onready var fourtyBar = $"Variables/VolGrid/40Rect"
@onready var sixtyBar = $"Variables/VolGrid/60Rect"
@onready var eightyBar = $"Variables/VolGrid/80Rect"
@onready var hundredBar = $"Variables/VolGrid/100Rect"
@onready var nodeArr = [twentyBar,fourtyBar,sixtyBar,eightyBar,hundredBar]
#AudioServer.get_bus_index("Master")
@onready var master = AudioServer.get_bus_index("Master")
@onready var masterfull = AudioServer.get_bus_index("Master")




func _ready() -> void:
	AudioServer.set_bus_volume_linear(master,1)
	

func checkVol(rectArr):
	var index = 0
	for rect in rectArr:
		if rectArr[index] == false:
			nodeArr[index].self_modulate =  Color (1,1,1,0.5)
		elif rectArr[index] == true:
			nodeArr[index].self_modulate =  Color (1,1,1,1)
		index += 1
	


func _on_20_pressed() -> void:
	print("20%")
	var locRectArr = [true,false,false,false,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.2)

func _on_40_pressed() -> void:
	print("40%")
	var locRectArr = [true,true,false,false,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.4)

func _on_60_pressed() -> void:
	print("60%")
	var locRectArr = [true,true,true,false,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.6)

func _on_80_pressed() -> void:
	print("80%")
	var locRectArr = [true,true,true,true,false]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 0.8)

func _on_100_pressed() -> void:
	print("100%")
	var locRectArr = [true,true,true,true,true]
	checkVol(locRectArr)
	AudioServer.set_bus_volume_linear(master, 1)
