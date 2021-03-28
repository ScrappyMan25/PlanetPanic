extends Node2D

export (float) var Speed
export (int) var Radius
export (Vector2) var Center = Vector2(0.0, 0.0)
var mouseInArea : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Distance From Sun
	$Planet.position.x = Radius
	
	#Offset Along Orbit
	rotation = rand_range(0.0, 360.0)
	pass # Replace with function body.

func _draw() -> void:
	#Visual Orbit
	draw_circle_arc(Center, Radius, 0 , 360, Color(1,1,1,1))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouseInArea && Input.is_action_pressed("ui_select"):
		rotation = get_global_mouse_position().angle_to_point(position)
		pass
	else:
		print(rotation)
		rotation += Speed/10 * delta
		pass
	pass

# Func to draw circle
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 100
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)


func _on_Planet_area_entered(_area: Area2D) -> void:
	print(_area.get_parent().name)
	if "Asteroid" in _area.get_parent().name:
		_area.get_parent().queue_free()
		queue_free()
	pass # Replace with function body.


func _on_Planet_mouse_entered() -> void:
	mouseInArea = true
	pass # Replace with function body.


func _on_Planet_mouse_exited() -> void:
	mouseInArea = false
	pass # Replace with function body.
