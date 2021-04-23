extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var explosion_velocity = Vector3(0, 0, 0)
var position = Vector3(0,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	self.apply_central_impulse(explosion_velocity)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#self.apply_central_impulse(explosion_velocity)
#	pass
