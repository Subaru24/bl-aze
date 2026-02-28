extends Control

const CSVDIR = "user://storedData/"
const CSVFILE = CSVDIR + "scores.csv"

var time = Globals.totalTime
var minutes = int(time / 60)
var seconds = time % 60


func _on_line_edit_text_submitted(text) -> void :
        if len(text) > 10:
            $Result.text = "NAME MUST BE LESS THAN 10 CHARACTERS"
            return
        else:
            writeToCSV(text)
            $Result.text = "DATA HAS BEEN SAVED"



func _ready() -> void :
    time = "%02d:%02d" % [minutes, seconds]
    $TotalPoints.text = "YOU GOT " + str(Globals.totalPoints) + " POINTS IN TOTAL!"
    $TotalTime.text = "YOU TOOK " + time + " IN TOTAL"

func writeToCSV(playerName):
    print(OS.get_user_data_dir())

    var player = playerName
    var points = Globals.totalPoints
    var date = Time.get_datetime_string_from_system()

    time = "%02d:%02d" % [minutes, seconds]


    var newData = PackedStringArray([player, points, time, date])
    print(newData)

    print("Dir exists after create:", DirAccess.dir_exists_absolute(CSVDIR))


    if not DirAccess.dir_exists_absolute(CSVDIR):
        DirAccess.make_dir_recursive_absolute(CSVDIR)
    var file = ""

    if FileAccess.file_exists(CSVFILE):
        file = FileAccess.open(CSVFILE, FileAccess.READ_WRITE)

    else:
        file = FileAccess.open(CSVFILE, FileAccess.WRITE)


    print("File exists after create:", FileAccess.file_exists(CSVFILE))
    print(CSVFILE)








    if file == null:
        print(" File not loaded :( ")
        print("Error code:", FileAccess.get_open_error())
        return null
    file.seek_end()
    file.store_csv_line(newData)
    file.close()
