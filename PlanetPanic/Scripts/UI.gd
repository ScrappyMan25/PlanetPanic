extends CanvasLayer

var SoundScene : Node

func _ready():
	SoundScene = get_parent().get_node("SoundScene")
	#get score from player
	# update_score(get_node("../[ScriptLocation].ScoreFunction"))
	set_visibility(false) #Set some visiblity to false at the start
	update_score(0)
	for c in get_children():
		if "Game_Over_" in c.name:
			c.hide()
			pass
		pass
	pass

func update_score(score : int) -> void:
	#Change the text of score lable
	$Score.text = "SCORE: " + score as String
	pass

func set_visibility(is_visible):
	for node in get_children():#look for all child node and hide if its not in Interface
		if node.name == "Button":
			node.visible = is_visible
		pass
	pass

func game_Over():
	for c in get_children():
		if "Game_Over_" in c.name:
			c.show()
			pass
		pass
	$PauseButton.hide()
	pass

func _on_PauseButton_pressed(): #When pause button is clicked. Pause everything and vice versa (like a on/off switch)
	SoundScene.get_node("Select").play()
	set_visibility(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	pass

func _on_Continue_pressed(): #Unpause everyting when the continue button is clicked
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
	SoundScene.get_node("Select").play()
	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	if err:
		print(err)
	get_tree().paused = false
	set_visibility(false)
	pass # Replace with function body.
