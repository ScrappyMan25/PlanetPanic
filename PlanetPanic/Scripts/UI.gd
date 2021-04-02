extends CanvasLayer

var SoundScene : Node
var PlanetReference : Node2D

var powerUpSprites : Dictionary = {
	1 : load("res://Assets/Game_Assets/Power-Ups/Coins/DoublePoints.png"),
	3 : load("res://Assets/Game_Assets/Power-Ups/Coins/MiniSunCoin.png"),
}

func _ready():
	SoundScene = get_parent().get_node("SoundScene")
	$Blur.hide()
	#get score from player
	# update_score(get_node("../[ScriptLocation].ScoreFunction"))
	set_visibility(false) #Set some visiblity to false at the start
	update_score(0)
	for c in get_children():
		if "Game_Over_" in c.name:
			c.hide()
			pass
		pass
	$WishingStar.hide()
	pass

func _process(_delta: float) -> void:
	if $SunMeterBar/SpriteFadeTimer.time_left:
		$SunMeterBar/PowerUpDisplay.modulate.a8 = $SunMeterBar/SpriteFadeTimer.time_left * 51
		pass
	pass

func update_score(score : int) -> void:
	#Change the text of score lable
	$Score.text = "SCORE: " + score as String
	$FinalScore.text = score as String
	pass

func setPowerUpSprite(_type : int) -> void:
	#use type to assign texture to $PowerUpDisplay
	$SunMeterBar/PowerUpDisplay.texture = powerUpSprites.get(_type)
	$SunMeterBar/PowerUpDisplay.modulate.a8 = 255
	$SunMeterBar/SpriteFadeTimer.start()
	pass

func set_visibility(_is_visible):
	for node in get_children():#look for all child node and hide if its not in Interface
		if node.name == "Button":
			node.visible = _is_visible
#			if _is_visible:
#				node.show()
#			else:
#				node.hide()
		pass
	pass

func ShootingStarUI(planetRef : Node2D) -> void:
	get_tree().paused = true
	$WishingStar.show()
	PlanetReference = planetRef
	pass

func PowerUpSelected(_powerUp : int) -> void:
	$WishingStar.hide()
	get_tree().paused = false
	PlanetReference.call_deferred("PowerUp", _powerUp)
	pass

func game_Over():
	for c in get_children():
		if "Game_Over_" in c.name:
			c.show()
			pass
		pass
	$PauseButton.hide()
	$SunMeterBar.hide()
	$Score.hide()
	$FinalScore.show()
	pass

#Signals

func _on_PauseButton_pressed(): #When pause button is clicked. Pause everything and vice versa (like a on/off switch)
#	SoundScene.get_node("Select").play()
	set_visibility(true)
	$PauseButton.hide()
	get_tree().paused = true
#	SoundScene.get_node("")
	pass

func _on_Continue_pressed(): #Unpause everyting when the continue button is clicked
	$PauseButton.show()
	$SunMeterBar.show()
	$Blur.hide()
	SoundScene.get_node("Select").play()
	get_tree().paused = false
	set_visibility(false)
	pass

func _on_Restart_pressed():
	SoundScene.get_node("Select").play()
	get_tree().paused = false
	set_visibility(false)
	var err = get_tree().reload_current_scene()
	if err:
		print(err)
	pass # Replace with function body.

func _on_MainMenu_pressed():
#	SoundScene.get_node("Select").play()
	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	if err:
		print(err)
	get_tree().paused = false
	set_visibility(false)
	pass # Replace with function body.


func _on_ExtraPlanetWish_pressed() -> void:
	PowerUpSelected(2)
	pass # Replace with function body.


func _on_ShieldWish_pressed() -> void:
	PowerUpSelected(5)
	pass # Replace with function body.


func _on_DoublePointsWish_pressed() -> void:
	PowerUpSelected(1)
	pass # Replace with function body.


func _on_FlameAnim_timeout() -> void:
	var truth : bool = $SunMeterBar/SunFlames1.visible
	$SunMeterBar/SunFlames1.visible = !truth
	$SunMeterBar/SunFlames2.visible = truth
	$SunMeterBar/FlameAnim.start()
	pass # Replace with function body.


func _on_SpriteFadeTimer_timeout() -> void:
	$SunMeterBar/PowerUpDisplay.modulate.a8 = 0
	pass # Replace with function body.
