extends Node

var Score : int = 0
var number_of_planets : int = 0

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

func _on_ScoreTimer_timeout() -> void:
	Score += number_of_planets
	$ScoreTimer.start()
	UpdateScore()
	pass # Replace with function body.

func _on_Sun_asteroid_hit() -> void:
	Score += 10
	UpdateScore()
	pass # Replace with function body.
