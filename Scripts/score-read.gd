extends Control

var jsonPath = "res://data/template.json"
var csvPath = "res://data/template.csv"


func _ready() -> void:
	#sortTimeCSV()
	writeDataCSV()
	display(null)



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
	# Less than is used as it should go quickest to slower time (ascending order)
	display(data)

func sortDateCSV():
	var data = loadDataCSV()
	data.sort_custom(func(a, b): return int(a[3]) > int(b[3]))
	display(data)


# The function that can write data to the CSV for storage

func writeDataCSV():
	# Test Data to be used
	var player = "test3"
	var points = 2000
	var time = "00:05:45:00"
	var date = Time.get_datetime_string_from_system() # Get the current date and time

	
	var newData = PackedStringArray([player,points,time,date])
	print(newData)
	#Packed String Array makes it into a suited format for a CSV
	
	var file = FileAccess.open(csvPath,FileAccess.READ_WRITE) 
	# READ_WRITE so I'll be able to append
	
	if file == null:
		print(" File not loaded :( ")
		return null
	file.seek_end() # So it appends to the end of the file
	file.store_csv_line(newData)
	file.close()
		
		
	
	
	
