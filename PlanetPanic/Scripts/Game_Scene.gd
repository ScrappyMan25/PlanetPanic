extends Node

var Score : int = 0
var number_of_planets : int = 0
var ScoreMultiplier : int = 1

var PlanetSystem : PackedScene = preload("res://Scenes/PlanetSystem.tscn")

var PlanetRadius : Array = [
	100 + (randi() % 10),
	145 + (randi() % 10)
]

var PlanetExists : Array = [
	true,
	true
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	# Find number of Planets
	$SoundScene/SpaceMusic.call_deferred("play")
	for c in get_children():
		if "PlanetSystem" in c.name:
			c.Radius = PlanetRadius[number_of_planets]
			c.get_node("Planet").position.x = c.Radius
			number_of_planets += 1
			pass
	pass # Replace with function body.

func UpdateScore() -> void:
	$UI.call_deferred("update_score", Score)
	if Score % 500 == 0 && number_of_planets < 5:
		Add_Planet()
	pass

func GameOver() -> void:
	print("GAME OVER!")
	
	#Sun Crying
	$Sun.set_deferred("GameOver", true)
	$Sun/AnimatedSprite.play("Sun_Sad")
	$SoundScene/GameOver.call_deferred("play")
	$InteractableManager.queue_free()
	$UI.call_deferred("game_Over")
	pass

func WipeAsteroids() -> void:
	$InteractableManager.call_deferred("AsteroidWipe")
	pass

func Add_Planet() -> void:
	var p = PlanetSystem.instance()
	p.Speed = rand_range(0.75, 2)
	if number_of_planets == PlanetRadius.size():
		#Add new Radius 
		var r = 100 + (45 * (PlanetRadius.size())) + (randi() % 10)
		PlanetRadius.push_back(r)
		PlanetExists.push_back(true)
		p.Radius = r
		pass
	else:
		var i = PlanetExists.find(false)
		p.Radius = PlanetRadius[i]
		PlanetExists[i] = true
		pass
	number_of_planets += 1
	add_child(p, true)
	#Camera Adjustment
	#TODO
	pass

# Signals

func _on_planetDestroyed(_Radius : int) -> void:
	#Update the planet counter for score multiplier
#	print("Planet Destroyed")
	$Sun/AnimatedSprite.play("Sun_Sad")
	PlanetExists[PlanetRadius.find(_Radius)] = false
	number_of_planets -= 1
	if number_of_planets == 0:
		#gameOver
		GameOver()
		pass
	pass

func _on_ScoreTimer_timeout() -> void:
	Score += number_of_planets * ScoreMultiplier
	$ScoreTimer.start()
	UpdateScore()
	pass # Replace with function body.

func _on_Sun_asteroid_hit() -> void:
	Score += 10 * ScoreMultiplier
	UpdateScore()
	pass # Replace with function body.

#Called when Game over sound ends
func _on_SoundScene_GameOver() -> void:
	#GameOver
	
	pass # Replace with function body.

func _on_SpaceMusic_finished() -> void:
	$SoundScene/SpaceMusic.play()
	pass # Replace with function body.
