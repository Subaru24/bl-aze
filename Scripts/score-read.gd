extends Control

var jsonPath = "res://data/template.json"
var csvPath = "res://data/template.csv"


func _ready() -> void:
	#theInfo(null)
	loadDataCSV()
	writeDataCSV()

func loadDataCSV():
	var scoreList = []
	var file = FileAccess.open(csvPath,FileAccess.READ)
	if file == null:
		print(" File not loaded :( ")
		return scoreList
	while not file.eof_reached():
		var line = file.get_line()
		scoreList.append(line.split(",")) # Splits elements by comma
	file.close()
	for line in scoreList:
		print(line)


func writeDataCSV():
	var player = "test3"
	var points = 2000
	var time = "00:05:45:00"
	var date = Time.get_datetime_string_from_system()
	var newData = [player,points,time,date]
	newData = PackedStringArray(newData)
	var file = FileAccess.open(csvPath,FileAccess.READ_WRITE) # READ_WRITE so I'll be able to append
	if file == null:
		print(" File not loaded :( ")
		return null
	file.seek_end()
	file.store_csv_line(newData)
	file.close()
		
		
	
	
	




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

		
			
		
