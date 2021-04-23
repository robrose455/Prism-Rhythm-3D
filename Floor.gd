extends StaticBody

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

var track_colors = ["Green", "LightBlue", "Blue", "Purple", "Red", "Orange", "Yellow", "White"]

var grad = Gradient.new()
var counting = 0

func _ready():
	
	for i in range (8):
		grad.add_point(i, colors.get(track_colors[i]))
		
	grad.add_point(9, "#9df584")
		
	pass # Replace with function body.



func _process(delta):
	
	#print(counting)
	counting += 1
	
	var material = SpatialMaterial.new()
	material.albedo_color = grad.interpolate(counting * 0.001)
	counting += 1
	if counting > 9000:
		counting = 0
	#print(color_index)
	
	get_node("MeshInstance").set_material_override(material)
	pass
