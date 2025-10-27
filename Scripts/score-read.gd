extends Control

var jsonPath = "res://data/template.json"


func _ready() -> void:
	#theInfo(null)
	sortPoints()

func loadData():
	var file = FileAccess.open(jsonPath,FileAccess.READ)
	var content = file.get_as_text()
	print(content)
	var info = JSON.parse_string(content)
	return info

func theInfo(sorter):
	if sorter == null:
		var data = loadData()
		for entry in data["scoreData"]:
			print(entry["playerName"] + "		" + str(entry["points"]) + "		"  + entry["timeTaken"] + "		"  + entry["date"])
	else:
		for entry in sorter:
			print(entry["playerName"] + "		" + str(entry["points"]) + "		"  + entry["timeTaken"] + "		"  + entry["date"])

func sortDate():
	var data = loadData()
	var score = data["scoreData"]
	score.sort_custom(func (a,b): return a["date"] > b["date"])
	theInfo(score)

func sortPoints():
	var data = loadData()
	var score = data["scoreData"]
	score.sort_custom(func (a,b): return a["points"] > b["points"])
	theInfo(score)

		
			
		
