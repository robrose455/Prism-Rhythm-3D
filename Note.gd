extends KinematicBody

var scored = false
var velocity = Vector3(0,0,-20)
var color = null
var proxymat = SpatialMaterial.new()

var proxyNoteScene = preload("res://ProxyNote.tscn")

# Called when the node enters the scene tree for the first time.

func ReplaceNote():
	
	var proxyNote = proxyNoteScene.instance()
	proxyNote.translation.x = self.translation.x
	proxyNote.translation.z = self.translation.z
	proxyNote.translation.y = self.translation.y + 3
	proxymat.albedo_color = color
	proxyNote.get_node("MeshInstance").set_material_override(proxymat)
	get_parent().add_child(proxyNote)
	
	var force = Vector3(0,20,0)
	proxyNote.add_central_force(force)
	
func _ready():
	
	self.translation.z += 9
	
	pass # Replace with function body.



func _physics_process(delta):
	
	var coll_info = move_and_collide(velocity * delta)
	
	if coll_info:
		
		var body = coll_info.collider
		
		if body.name == "Piston" and scored == false:
			scored = true
			print("hit")
			ReplaceNote()
			queue_free()
			
		
	if self.translation.z < -40:
		queue_free()
		
#	pass
