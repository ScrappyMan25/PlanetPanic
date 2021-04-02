extends Node2D

export (float) var Speed
export (int) var Radius
export (Vector2) var Center = Vector2(0.0, 0.0)
var mouseInArea : bool = false
signal planetDestroyed
var PlanetDestroySound = false
var default_Planet_Sprite

var control : bool = false

#Parent Game Scene Ref
var Game_Scene : Node
var SoundScene : Node

var isSun : bool = false
var isShield : bool = false

var rotation_direction = [
	-1,
	1
]

#Interactables Key
#	0	Asteroid,
#	1	Double_Points,
#	2	Extra_Planet,
#	3	Mini_Sun,
#	4	Screen_Wipe,
#	5	Shield,
#	6	Wishing_Star
#	7	ReverseOrbit
#	8	SpeedDownOrbit
#	9	SpeedUpOrbit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	#Distance From Sun
	$Planet.position.x = Radius
	
	#Offset Along Orbit
	rotation = rand_range(0.0, 360.0)
	
	#Choose Rotation Direction
	rotation_direction.shuffle()
	rotation_direction.pop_back()
	rotation_direction = rotation_direction[0]
	
	#Set GameScene
	Game_Scene = get_parent()
	SoundScene = Game_Scene.get_node("SoundScene")
	
	#TODO
	#SetSprite / Animation Sprite
	default_Planet_Sprite = (randi() % 8) as String
	$Planet/AnimatedSprite.play(default_Planet_Sprite)
	
	#Connect Signals
	var err = connect("planetDestroyed", get_parent(), "_on_planetDestroyed")
	if err:
		print(err)
	pass # Replace with function body.

func _draw() -> void:
	#Visual Orbit
	draw_circle_arc(Center, Radius, 0 , 360, Color(1,1,1,1))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !control:
		rotation += Speed/10 * delta * rotation_direction
	else:
		control = Input.is_mouse_button_pressed(1)
		pass
	pass

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton) && (mouseInArea):
		control = event.is_pressed()
		pass
	elif (event is InputEventScreenTouch) && (mouseInArea):
		var _input = event.position - (get_viewport_rect().size/2)
		control =  event.is_pressed()
		pass
	elif (event is InputEventScreenDrag) && control:
		var input = event.position - (get_viewport_rect().size /2)
		rotation = input.angle_to_point(global_position)
		pass
	elif (event is InputEventMouseMotion) && control:
		var input = event.position - (get_viewport_rect().size /2)
		rotation = input.angle_to_point(position)
		pass
	pass

# Func to Check Interactable Collision Type
func checkCollisionType(I_Name : String) -> int:
	#Asteroid
	if "Asteroid" in I_Name:
		return 0
	#Double_Points
	elif "Double_Points" in I_Name:
		return 1
	#Extra_Planet
	elif "Extra_Planet" in I_Name:
		return 2
	#Mini_Sun
	elif "Mini_Sun" in I_Name:
		return 3
	#Screen_Wipe
	elif "Screen_Wipe" in I_Name:
		return 4
	#Shield
	elif "Shield" in I_Name:
		return 5
	#Wishing_Star
	elif "Wishing_Star" in I_Name:
		return 6
	#ReverseOrbit
	elif "ReverseOrbit" in I_Name:
		return 7
	#SpeedDownOrbit
	elif "SpeedDownOrbit" in I_Name:
		return 8
	#SpeedUpOrbit
	elif "SpeedUpOrbit" in I_Name:
		return 9
	return -1

# Func to Implement PowerUps
func PowerUp(type : int) -> void:
# If Asteroid Do Nothing
	match type:
#	1	Double_Points,
		1:
			#StartPowerUp Timer- WaitTime 5 Seconds
			$PowerUp_Timer.start()
			#Set Score multiplier to 2
			Game_Scene.set_deferred("ScoreMultiplier", 2)
			# When Timer Expires set multiplier back to 1 - Handeled in Signal
			pass
#	2	Extra_Planet,
		2:
			Game_Scene.call_deferred("Add_Planet")
			pass
#	3	Mini_Sun,
		3:
			#StartPowerUp Timer- WaitTime 5 Seconds
			$PowerUp_Timer.start()
			#Set Sprite to Sun and Change porperty to TRUE 
			$Planet/AnimatedSprite.scale = Vector2 (0.4, 0.4)
			$Planet/AnimatedSprite.play("Mini_Sun")
			isSun = true
			pass
#	4	Screen_Wipe,
		4:
			# Call game Scene to delete all Asteroids on Scene
			Game_Scene.call_deferred("WipeAsteroids")
			pass
#	5	Shield,
		5:
			# Set property to true # TODO
			$PowerUp_Timer.start()
			$Planet/ShieldParticles.show()
			isShield = true
			pass
#	6	Wishing_Star
		6:
			# Pause Scene And Open GUI To Select a Custom PowerUp. and then Run the Power up Func with that type Int
			Game_Scene.get_node("UI").call_deferred("ShootingStarUI", self)
			pass
#	7	ReverseOrbit
		7:
			rotation_direction *= -1
			pass
#	8	SpeedDownOrbit
		8:
			Speed -= 0.5
			pass
#	9	SpeedUpOrbit
		9:
			Speed += 0.5
			pass
	#PlayPowerUpSoundHere
	
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
#		draw_multiline(points_arc, color, 2.0)

#Signals

func _on_Planet_area_entered(_area: Area2D) -> void:
	var InteractableType : int = checkCollisionType(_area.get_parent().name)
	
	match InteractableType:
		#Asteroid
		0:
			_area.get_parent().queue_free()
			# If Sun PowerUp -> Call sunAsteroid Hit in Parent
			if isSun:
				Game_Scene.call_deferred("_on_Sun_asteroid_hit")
				pass
			# If Shield -> Do nothing destroy asteroid
			# Else Asteroid Hit Planet -> Planet go Boom Boom!
			elif !isShield:
				SoundScene.get_node("PlanetDestroy").call_deferred("play")
				emit_signal("planetDestroyed", Radius)
				queue_free()
		#If not an Ansteroid 
		_:
#			print("UNKNOWN OBJECT: " + _area.get_parent().name)
			if !"FireBall" in _area.get_parent().name:
				_area.get_parent().queue_free()
	
	#PowerUpImplementation
	PowerUp(InteractableType)
	pass

func _on_Planet_mouse_entered() -> void:
	mouseInArea = true
	pass # Replace with function body.

func _on_Planet_mouse_exited() -> void:
	mouseInArea = false
	pass # Replace with function body.

func _on_PowerUp_Timer_timeout() -> void:
	#PowerUp Expires
	Game_Scene.set_deferred("ScoreMultiplier", 1)
	isSun = false
	isShield = false
	$Planet/AnimatedSprite.play(default_Planet_Sprite)
	$Planet/AnimatedSprite.scale = Vector2(1, 1)
	$Planet/ShieldParticles.hide()
	pass # Replace with function body.


func _on_Planet_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch:# || event is InputEventMouseButton:
		control = true
	pass # Replace with function body.
