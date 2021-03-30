extends Node2D
class_name Interactable

var Speed
var Direction : Vector2
var area2d : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Connects Signal of Area to the Func
func _connectAreaSignal() -> void:
	var err
	if area2d:
		err = area2d.connect("area_entered", self, "_on_Interactable_area_entered")
	if err:
		print(err)
	pass

#Movement
func _process(delta: float) -> void:
	#move towards the center
	position += Direction * Speed * delta
#	print(position)
	pass

#Properties when instances by Manager
func _set_properties(_speed: float, _destination : Vector2, _spawnLocation : Vector2) -> void:
	#speed
	Speed = _speed
	#location
	position = _spawnLocation
	
	#setDirection
	Direction = _destination - position
	Direction = Direction.normalized()
	#ray setup
	$RayCast2D.cast_to = _destination
	
	#Particle Rotation
#	var angleTo : float = _spawnLocation.angle_to(_destination)
#	var angleTo : float = _destination.angle_to(_spawnLocation)
#	$AnimatedSprite/CPUParticles2D.rotate(angleTo)
	pass


func _on_Interactable_area_entered(_area: Area2D) -> void:
	pass # Replace with function body.