extends Control

var jsonPath = "res://data/template.json"
var csvPath = "res://data/template.csv"


func _ready() -> void:
	#theInfo(null)
	loadDataCSV()
	sortTimeCSV()
	#writeDataCSV()



# The function that loads the data of the CSV in order to put in a table format of sorts


func loadDataCSV():
	var scoreList = []
	var file = FileAccess.open(csvPath, FileAccess.READ)
	if file == null:
		print("File not loaded :(")
		return scoreList
	
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		if line == "":
			continue
		scoreList.append(line.split(","))
	
	file.close()
	return scoreList

# Displays the table 
func display(arg):
	var data = arg if arg != null else loadDataCSV() 
	# Load the order of the data from the parameter if something is being passed in
	
	var header = ["Player","Points","Time","Date"] 
	# Header field in script now so it's not affected by the sorting method
	print("\t".join(header))
	for line in data:
		if len(line) == 4:
			var lineStr = "\t".join(line)
			print(lineStr)
	return data


func sortPointsCSV():
	var data = loadDataCSV()
	data.sort_custom(func(a, b): return int(a[1]) > int(b[1])) 
	# e.g 1500 > 300, returns true and swaps them around, does this with the rest
	
	display(data) 

func sortTimeCSV():
	var data = loadDataCSV()
	data.sort_custom(func(a, b): return int(a[2]) < int(b[2]))
	display(data)

func sortDateCSV():
	var data = loadDataCSV()
	data.sort_custom(func(a, b): return int(a[3]) > int(b[3]))
	display(data)
#func sortDateCSV():
#	if a[3] > b[3]:
#		return true
#	else:
#		return false
#	

# The function that can write data to the CSV for storage

func writeDataCSV():
	# Test Data to be used
	var player = "test3"
	var points = 2000
	var time = "00:05:45:00"
	var date = Time.get_datetime_string_from_system()

	
	var newData = [player,points,time,date]
	newData = PackedStringArray(newData) #Packed String Array makes it into a suited format for a CSV
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

		
			
		
