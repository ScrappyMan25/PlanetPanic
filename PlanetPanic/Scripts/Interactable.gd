extends Node2D
class_name Interactable

var Speed
var Direction : Vector2
var area2d : Area2D
var MouseInArea : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Connects Signal of Area to the Func
func _connectAreaSignal() -> void:
	var err
	var err2
	var err3
	if area2d:
		err = area2d.connect("area_entered", self, "_on_Interactable_area_entered")
		err2 = area2d.connect("mouse_entered", self, "_on_Interactable_mouse_entered")
		err3 = area2d.connect("mouse_exited", self, "_on_Interactable_mouse_exited")
	if err:
		print(err)
	if err2:
		print(err)
	if err3:
		print(err)
	pass

#Movement
func _process(delta: float) -> void:
	#move towards the center
	position += Direction * Speed * delta
	
	if MouseInArea && "Asteroid" in name && Input.is_action_just_pressed("ui_select"):
		get_parent().get_parent().get_node("Sun").call_deferred("FireBall", position)
		pass
	
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
	if "Asteroid" in name || "Wishing_Star" in name:
		var angle : float = _spawnLocation.angle_to_point(_destination)
		#spawnLocation | Destination | Direction
#		angleTo = position.angle_to(_destination)
		$AnimatedSprite/CPUParticles2D.rotate(angle)
	pass

func _on_Interactable_area_entered(_area: Area2D) -> void:
	if "FireBall" in _area.get_parent().name && "Asteroid" in name:
		#FireBall
		get_parent().get_parent().call_deferred("addScore", 50)
		get_parent().get_parent().get_node("SoundScene/PlanetDestroy").play()
		queue_free()
		_area.get_parent().queue_free()
		pass
	pass # Replace with function body.

func _on_Interactable_mouse_entered() -> void:
	MouseInArea = true
	pass
	
func _on_Interactable_mouse_exited() -> void:
	MouseInArea = false
	pass
