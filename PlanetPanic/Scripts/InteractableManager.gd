extends Node2D

var Interactables : Dictionary = {
	"Asteroid" : preload("res://Scenes/Interactables/Asteroid.tscn"),
	"Double_Points" : preload("res://Scenes/Interactables/Double_Points.tscn"),
	"Extra_Planet" : preload("res://Scenes/Interactables/Extra_Planet.tscn"),
	"Mini_Sun" : preload("res://Scenes/Interactables/Mini_Sun.tscn"),
	"Screen_Wipe" : preload("res://Scenes/Interactables/Screen_Wipe.tscn"),
	"Shield" : preload("res://Scenes/Interactables/Shield.tscn"),
	"Wishing_Star" : preload("res://Scenes/Interactables/Wishing_Star.tscn"),
	"ReverseOrbit" : preload("res://Scenes/Interactables/ReverseOrbit.tscn"),
	"SpeedDownOrbit" : preload("res://Scenes/Interactables/SpeedDownOrbit.tscn"),
	"SpeedUpOrbit" : preload("res://Scenes/Interactables/SpeedUpOrbit.tscn")
}

var Key : Array = [
	"Asteroid",
	"Double_Points",
	"Extra_Planet",
	"Mini_Sun",
	"Screen_Wipe",
	"Shield",
	"Wishing_Star",
	"ReverseOrbit",
	"SpeedDownOrbit",
	"SpeedUpOrbit"
]

var Interactable_Bag : Array = [
	1,
	1,
	1,
	1,
	1,
	1,
	2,
	2,
	2,
	2,
	2,
	2,
	5,
	5,
	5,
	5,
	5,
	5,
	7,
	7,
	7,
	8,
	8,
	8,
	9,
	9,
	9,
	3,
	4,
	6
]

var Game_Scene : Node
var SoundScene : Node

var PowerUp_Keys : Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	spawn_Asteroid()
	Game_Scene = get_parent()
	SoundScene = Game_Scene.get_node("SoundScene")
	#Keys of Dict Interactables (-Asteroids) so as to randomise the Spawns
	PowerUp_Keys = Interactables.keys()
	PowerUp_Keys.remove(0)
	pass # Replace with function body.


func spawn_Asteroid() -> void:
	var newAsteroid = Interactables.Asteroid.instance()
	#Set Properties Here
	var a_speed = 150.0
	var a_location = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * 600 * get_parent().get_node("Camera2D").zoom.x
	var a_destination = position
	newAsteroid._set_properties(a_speed, a_destination, a_location)
	add_child(newAsteroid, true)
	pass

func spawn_PowerUp() -> void:
	#Randomise PowerUps
	PowerUp_Keys.shuffle()
	var PowerUp = Interactables.get(PowerUp_Keys[0]).instance()
	var a_speed = 150.0
	var a_location = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * 600 * get_parent().get_node("Camera2D").zoom.x
	var a_destination = position
	PowerUp._set_properties(a_speed, a_destination, a_location)
	add_child(PowerUp, true)
	pass

func AsteroidWipe() -> void:
	$Asteroid_Spawn_Timer.stop()
	for i in get_children():
		if "Asteroid" in i.name && !("_Spawn_Timer") in i.name:
			i.queue_free()
			get_parent().call_deferred("_on_Sun_asteroid_destroyed")
#			get_parent().get_node("SoundScene").get_node("PlanetDestroy").play()
			SoundScene.get_node("PlanetDestroy").play()
	$Asteroid_Spawn_Timer.start()
	pass

#Signals

func _on_SpawnTimer_timeout() -> void:
	#Run Clocked FUnction
	spawn_Asteroid()
	$SpawnTimer.start()
	pass # Replace with function body.


func _on_Asteroid_Spawn_Timer_timeout() -> void:
	spawn_Asteroid()
	$Asteroid_Spawn_Timer.start()
	pass # Replace with function body.


func _on_PowerUp_Spawn_Timer_timeout() -> void:
	spawn_PowerUp()
	$PowerUp_Spawn_Timer.start()
	pass # Replace with function body.
