extends Node2D

var Speed
var Direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	#move towards the center
	position += Direction * Speed * delta
#	print(position)
	pass

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
	pass

func _on_AsteroidArea_area_entered(_area: Area2D) -> void:
	print(_area.get_parent().name)
	pass # Replace with function body.
