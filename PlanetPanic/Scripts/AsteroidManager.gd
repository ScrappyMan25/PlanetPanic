extends Node2D

var Asteroid = preload("res://Scenes/Interactables/Asteroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_Asteroid()
	pass # Replace with function body.


func spawn_Asteroid() -> void:
	var newAsteroid = Asteroid.instance()
	#Set Properties Here
	var a_speed = 150.0
	var a_location = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * 600
	var a_destination = position
	newAsteroid._set_properties(a_speed, a_destination, a_location)
	add_child(newAsteroid, true)
	pass

func _on_SpawnTimer_timeout() -> void:
	#Run Clocked FUnction
	spawn_Asteroid()
	$SpawnTimer.start()
	pass # Replace with function body.
