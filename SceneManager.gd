extends Spatial

var recording = false
var recordingData = {}
var cur_time = 0
var noteCount = 1

var walls_changed = {
	
	"A": 0,
	"S": 0,
	"D": 0,
	"F": 0,
	"J": 0,
	"K": 0,
	"L": 0,
	"SC": 0
}

var colors = {
	"Green": "#59ff00",
	"LightBlue" : "#00ffc3",
	"Blue": "#0000ff",
	"Purple": "#8000ff",
	
	"Red": "#ff0000",
	"Orange": "#ff9100",
	"Yellow": "#eeff00",
	"White": "#ffffff"	
}

var inputs = ["A", "S", "D", "F", "J", "K", "L", "SC"]
var track_colors = ["Green", "LightBlue", "Blue", "Purple", "Red", "Orange", "Yellow", "White"]

var GreenMat = SpatialMaterial.new()
var LightBlueMat = SpatialMaterial.new()
var BlueMat = SpatialMaterial.new()
var PurpleMat = SpatialMaterial.new()
var RedMat = SpatialMaterial.new()
var OrangeMat = SpatialMaterial.new()
var YellowMat = SpatialMaterial.new()
var WhiteMat = SpatialMaterial.new()

var GrayMat = SpatialMaterial.new()

var track_materials = [GreenMat, LightBlueMat, BlueMat, PurpleMat, RedMat, OrangeMat, YellowMat, WhiteMat]

var Song

func SaveRecordingData():
	
	var file = File.new()
	file.open("res://recording_data.json", File.WRITE)
	file.store_line(to_json((recordingData)))
	file.close()

func _ready():
	
	#Setting Wall Default Color
	GrayMat.albedo_color = "#757471"
	
	for i in range(8):
		
		track_materials[i].albedo_color = colors.get(track_colors[i])
		get_parent().get_node("Tracks/" + inputs[i] + "_Track/Piston/MeshInstance").set_material_override(track_materials[i])
		
	Song = get_parent().get_node("Songs/Dynamite")
	Song.play()
	
func _process(delta):
	
	cur_time = OS.get_ticks_msec() * delta
	
	if Input.is_key_pressed(KEY_R):
		recording = true
		print("Started Recording")
		
	if Input.is_key_pressed(KEY_T):
		SaveRecordingData()
		print("Recording Saved")
	
	for i in inputs:
		if Input.is_action_just_pressed(i):
			get_parent().get_node("Tracks/" + String(i) + "_Track/Piston/AnimationPlayer").play("Fire")
			get_parent().get_node("Tracks/" + String(i) + "_Track/Wall_Left/MeshInstance").set_material_override(track_materials[inputs.find(i)])
			get_parent().get_node("Tracks/" + String(i) + "_Track/Wall_Right/MeshInstance").set_material_override(track_materials[inputs.find(i)])
			
			walls_changed[String(i)] = 1
					
			if recording:
				
				var noteData = { 
					
					"key" : String(i),
					"time" : get_parent().get_node("Songs/Dynamite").get_playback_position()
					
				}
				
				recordingData[noteCount] = noteData
				noteCount += 1
			
			#Do lerp instead
		if walls_changed[String(i)] != 0:
			walls_changed[String(i)] += 1
			if walls_changed[String(i)] >= 10:
				get_parent().get_node("Tracks/" + String(i) + "_Track/Wall_Left/MeshInstance").set_material_override(GrayMat)
				get_parent().get_node("Tracks/" + String(i) + "_Track/Wall_Right/MeshInstance").set_material_override(GrayMat)
				walls_changed[String(i)] = 0
				
				
			

	pass
	
