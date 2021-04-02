extends Node

var Score : int = 0
var number_of_planets : int = 0
var ScoreMultiplier : int = 1
var limit : int = 500

var PlanetSystem : PackedScene = preload("res://Scenes/PlanetSystem.tscn")

var PlanetRadius : Array = [
	100 + (randi() % 10),
	145 + (randi() % 10)
]

var PlanetExists : Array = [
	true,
	true
]

#Shake Specific Stuff
# Referenced from https://kidscancode.org/godot_recipes/2d/screen_shake/

onready var noise = OpenSimplexNoise.new()
var noise_y = 0

var ScreenShake : Dictionary = {
	"decay" : 0.8,
	"max_offset" : Vector2(100,75),
	"max_roll" : 0.1,
	"trauma" : 0.0,
	"trauma_power" : 2
}

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
#	Set BG
	VisualServer.set_default_clear_color("322947")
	
#	Noise Setup
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2
#	for i in 4:
#		Add_Planet()
	pass # Replace with function body.

func _process(delta: float) -> void:
	if ScreenShake.trauma:
		ScreenShake.trauma = max(ScreenShake.trauma - ScreenShake.decay * delta, 0)
		shake()
		pass
	pass

func add_trauma(amount) -> void:
	ScreenShake.trauma = min(ScreenShake.trauma + amount, 1.0)
	pass

func shake():
	var amount = pow(ScreenShake.trauma, ScreenShake.trauma_power)
	noise_y += 1
	$Camera2D.rotation = ScreenShake.max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	$Camera2D.offset.x = ScreenShake.max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	$Camera2D.offset.y = ScreenShake.max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
	pass

func UpdateScore() -> void:
	$UI.call_deferred("update_score", Score)
	if Score > limit && number_of_planets < 5:
		Add_Planet()
		limit += 500
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
	add_trauma(1.0)
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
	call_deferred("add_child", p, true)
	#Camera Adjustment
	adjust_Camera_zoom()
	pass

func adjust_Camera_zoom():
	if PlanetExists.find_last(true) > 3:
		var zoom_value : float = 1 + 0.10 * (PlanetExists.find_last(true) - 3)
		$Camera2D.zoom = Vector2(zoom_value, zoom_value)
		pass
	else:
		$Camera2D.zoom = Vector2(1, 1)
		pass
#	print(get_viewport().size)
	$Camera2D.get_viewport_rect().size = $Camera2D/CPUParticles2D.emission_rect_extents
	pass

func addScore(s : int):
	Score += s * ScoreMultiplier
	UpdateScore()
	pass

# Signals

func _on_planetDestroyed(_Radius : int) -> void:
	#Update the planet counter for score multiplier
	$Sun/AnimatedSprite.play("Sun_Sad")
	PlanetExists[PlanetRadius.find(_Radius)] = false
	number_of_planets -= 1
	adjust_Camera_zoom()
	if number_of_planets == 0:
		#gameOver
		$SoundScene/SpaceMusic.stop()
		GameOver()
		pass
	add_trauma(0.5)
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
