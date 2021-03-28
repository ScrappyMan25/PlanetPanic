extends CanvasLayer

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
		if node.name != "Score" && node.name != "PauseButton":
			node.visible = is_visible
		pass
	pass

func _on_PauseButton_pressed(): #When pause button is clicked. Pause everything and vice versa (like a on/off switch)
	set_visibility(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	pass

func _on_Continue_pressed(): #Unpause everyting when the continue button is clicked
	get_tree().paused = false
	set_visibility(false)
	pass 
