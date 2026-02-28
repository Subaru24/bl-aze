extends Control

var jsonPath = "res://data/template.json"
var csvPath = "user://storedData/scores.csv"

var state = Globals.scoreState



func _ready() -> void :


    if state == "date":
        display(null)
    elif state == "points":
        sortPointsCSV()
    elif state == "time":
        sortTimeCSV()






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


func display(arg):

    for child in $GridContainer.get_children():
        if child.has_meta("dynamic"):
            child.queue_free()
    var data = arg if arg != null else sortDateCSV()


    var header = ["Player", "Points", "Time", "Date"]

    var regex = RegEx.new()
    regex.compile("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}")
    print("\t".join(header))
    for line in data:

        print(typeof(line))





        for entry in line:
            var result = regex.search(entry)
            if not result:
                var newLabel = Label.new()
                newLabel.text = str(entry)
                newLabel.set_meta("dynamic", true)
                $GridContainer.add_child(newLabel)

    return data


func sortPointsCSV():
    var data = loadDataCSV()
    data.sort_custom( func(a, b): return int(a[1]) > int(b[1]))


    display(data)

func sortTimeCSV():
    var data = loadDataCSV()
    data.sort_custom( func(a, b): return int(a[2]) < int(b[2]))

    display(data)

func sortDateCSV():
    var data = loadDataCSV()
    data.sort_custom( func(a, b): return int(a[3]) > int(b[3]))
    return data




func writeDataCSV():

    var player = "test3"
    var points = 2000
    var time = "00:05:45:00"
    var date = Time.get_datetime_string_from_system()


    var newData = PackedStringArray([player, points, time, date])
    print(newData)


    var file = FileAccess.open(csvPath, FileAccess.READ_WRITE)


    if file == null:
        print(" File not loaded :( ")
        return null
    file.seek_end()
    file.store_csv_line(newData)
    file.close()

func onSRecentPressed():
    display(null)
    state = "date"

func onSPointsPressed():
    sortPointsCSV()
    state = "points"

func onSTimePressed():
    sortTimeCSV()
    state = "time"

func onRefreshPressed():
    get_tree().reload_current_scene()
