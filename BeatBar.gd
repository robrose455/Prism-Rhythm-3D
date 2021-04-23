extends KinematicBody

var velocity = Vector3(0,0,-20)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.translation.z += 9
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	var coll_info = move_and_collide(velocity * delta)
	
	if self.translation.z <= -33:
		print("DEAD")
		
		queue_free()
	
	pass
