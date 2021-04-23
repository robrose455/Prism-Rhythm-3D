extends Spatial

var cur_time = 0
var buffer = 34
var bar_buffer = 36
var target_time 
var start = false
var note_index = 1

var bpm_ms = 60000.00/120.00 

onready var timer = get_parent().get_node("Timer")
onready var buffer_timer = get_parent().get_node("BufferTimer")

var noteScene = preload("res://Note.tscn")
var bbScene = preload("res://BeatBar.tscn")

var note_info = {}
var recording = false

func SpawnBeatBar():	
	
	var bb1 = bbScene.instance()
	var bb2 = bbScene.instance()
	var bb3 = bbScene.instance()
	var bb4 = bbScene.instance()
	var bb5 = bbScene.instance()
	var bb6 = bbScene.instance()
	var bb7 = bbScene.instance()
	var bb8 = bbScene.instance()
	
	bb1.translation.x += -17.5
	bb2.translation.x += -12.5
	bb3.translation.x += -7.5
	bb4.translation.x += -2.5
	bb5.translation.x += 2.5
	bb6.translation.x += 7.5
	bb7.translation.x += 12.5
	bb8.translation.x += 17.5
	
	
	get_parent().add_child(bb1)
	get_parent().add_child(bb2)
	get_parent().add_child(bb3)
	get_parent().add_child(bb4)
	get_parent().add_child(bb5)
	get_parent().add_child(bb6)
	get_parent().add_child(bb7)
	get_parent().add_child(bb8)
	
	pass
	
func SpawnNote(nk):
	
	#Create Note Instance
	var note = noteScene.instance()
	
	#Set Material
	var material = SpatialMaterial.new()
	
	#Blue
	if nk == "A":
		
		note.color = "#59ff00"
		material.albedo_color = "#59ff00"
		note.translation.x += get_parent().get_node("Tracks/A_Track/Track").translation.x
	
	#Red	
	if nk == "S":
		
		note.color = "#00ffc3"
		material.albedo_color = "#00ffc3"
		note.translation.x += get_parent().get_node("Tracks/S_Track/Track").translation.x
		
	if nk == "D":
		
		note.color = "#0000ff"
		material.albedo_color = "#0000ff"
		note.translation.x += get_parent().get_node("Tracks/D_Track/Track").translation.x
		
	if nk == "F":
		
		note.color = "#8000ff"
		material.albedo_color = "#8000ff"
		note.translation.x += get_parent().get_node("Tracks/F_Track/Track").translation.x
		
	if nk == "J":
		
		note.color = "#ff0000"
		material.albedo_color = "#ff0000"
		note.translation.x += get_parent().get_node("Tracks/J_Track/Track").translation.x
		
	if nk == "K":
		
		note.color = "#ff9100"
		material.albedo_color = "#ff9100"
		note.translation.x += get_parent().get_node("Tracks/K_Track/Track").translation.x
		
	if nk == "L":
		
		note.color = "#eeff00"
		material.albedo_color = "#eeff00"
		note.translation.x += get_parent().get_node("Tracks/L_Track/Track").translation.x
	
	if nk == "SC":
		
		note.color = "#ffffff"
		material.albedo_color = "#ffffff"
		note.translation.x += get_parent().get_node("Tracks/SC_Track/Track").translation.x
		
	note.get_node("MeshInstance").set_material_override(material)
		
	#Add Note To Scene
	add_child(note)

func LoadSong(title):
	
	var file = File.new()
	file.open(title + ".json", file.READ)
	var json_text = file.get_as_text()
	note_info = parse_json(json_text)
	file.close()
	
	target_time = note_info.get(String(note_index)).get("time")
	
	for i in len(note_info):
		
		#print(i)
		#print(note_info.get(String(i)))
		pass
				
func _ready():
	
	LoadSong("dynamite2")
	timer.set_wait_time(bpm_ms * 0.001)
	buffer_timer.set_wait_time(3.3)
	buffer_timer.start()

func _process(delta):
	
	cur_time = get_parent().get_node("Songs/Dynamite").get_playback_position() + 2
	print(get_parent().get_node("Songs/Dynamite").get_playback_position())
		
	if  cur_time >= target_time and note_index < len(note_info):
		
		var key = note_info.get(String(note_index)).get("key")

		SpawnNote(key)
		
		target_time = note_info.get(String(note_index + 1)).get("time")
		
		note_index += 1
	
	
func _on_Timer_timeout():
	
	SpawnBeatBar()
	pass


func _on_BufferTimer_timeout():
	
	timer.start()
	buffer_timer.stop()
	pass # Replace with function body.
