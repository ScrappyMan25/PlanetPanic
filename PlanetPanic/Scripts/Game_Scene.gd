extends Node

var Score : int = 0
var number_of_planets : int = 0
var GameOverScene : PackedScene = preload("res://Scenes/GameOver.tscn")
var Gameover = false

var ScoreMultiplier : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Find number of Planets
	for c in get_children():
		if "PlanetSystem" in c.name:
			number_of_planets += 1
			pass
	pass # Replace with function body.

func UpdateScore() -> void:
	$UI.call_deferred("update_score", Score)
	pass

func GameOver() -> void:
	print("GAME OVER!")
	#GameOver
	$GameOverSound.play()
	Gameover = true
#	var err = get_tree().change_scene_to(GameOverScene)
#	if err != OK:
#		print(err)
#	queue_free()
	pass

func WipeAsteroids() -> void:
	$InteractableManager.call_deferred("AsteroidWipe")
	pass

# Signals

func _on_planetDestroyed() -> void:
	#Update the planet counter for score multiplier
#	print("Planet Destroyed")
	number_of_planets -= 1
	if number_of_planets == 0:
		#gameOver
		GameOver()
		pass
	pass

func _on_planetAdded() -> void:
	#Update the planet counter for score multiplier
	
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


func _on_GameOver_finished():
	if Gameover == true:
		var err = get_tree().change_scene_to(GameOverScene)
		if err != OK:
			print(err)
		Gameover = false
		queue_free()
	pass # Replace with function body.
