extends CanvasLayer

var Restart = false
var Menu = false

func _ready():
	#get score from player
	# update_score(get_node("../[ScriptLocation].ScoreFunction"))
	set_visibility(false) #Set some visiblity to false at the start
	update_score(0)
	pass

func update_score(score : int) -> void:
	#Change the text of score lable
	$Score.text = "SCORE: " + score as String
	pass

func set_visibility(is_visible):
	for node in get_children():#look for all child node and hide if its not in Interface
		if node.name != "Score" && node.name != "PauseButton" && node.name != "Select":
			node.visible = is_visible
		pass
	pass

func _on_PauseButton_pressed(): #When pause button is clicked. Pause everything and vice versa (like a on/off switch)
	$Select.play()
	set_visibility(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	pass

func _on_Continue_pressed(): #Unpause everyting when the continue button is clicked
	$Select.play()
	get_tree().paused = false
	set_visibility(false)
	pass 


#func _on_Exit_pressed():
#	get_tree().quit()
#	get_tree()
#	pass # Replace with function body.


func _on_Restart_pressed():
	$Select.play()
#	var err = get_tree().reload_current_scene()
#	if err:
#		print(err)
	get_tree().paused = false
	set_visibility(false)
	Restart = true
	pass # Replace with function body.

func _on_MainMenu_pressed():
	$Select.play()
#	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
#	if err:
#		print(err)
	get_tree().paused = false
	set_visibility(false)
	Menu = true
	pass # Replace with function body.


func _on_Select_finished():
	if Restart == true:
		var err = get_tree().reload_current_scene()
		if err:
			print(err)
		Restart = false
	elif Menu == true:
		var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		if err:
			print(err)
		Menu = false
		queue_free()
	pass # Replace with function body.
