extends Control
@onready var twentyBar = $"Variables/VolGrid/20Rect"
@onready var fourtyBar = $"Variables/VolGrid/40Rect"
@onready var sixtyBar = $"Variables/VolGrid/60Rect"
@onready var eightyBar = $"Variables/VolGrid/80Rect"
@onready var hundredBar = $"Variables/VolGrid/100Rect"
@onready var nodeArr = [twentyBar,fourtyBar,sixtyBar,eightyBar,hundredBar]

#func _ready() -> void:
	
	

func checkVol(rectArr):
	var index = 0
	for rect in rectArr:
		if rectArr[index] == false:
			nodeArr[index].modulate =  Color (1,1,1,0.5)
		index += 1


			

	 


func _on_20_pressed() -> void:
	print("20%")
	var locRectArr = [true,false,false,false,false]
	checkVol(locRectArr)
	
	
