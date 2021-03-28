extends CanvasLayer

func _ready():
	#get score from player
	# update_score(get_node("../[ScriptLocation].ScoreFunction"))
	set_visibility(false)
	pass

#func update_score(score : int) -> void:
#	$Interface/Score.text = "SCORE: "+ score as String
#	pass

func set_visibility(is_visible):
	for node in get_children():#look for all child node and hide if its not in Interface
		if node.name != "Interface":
			node.visible = is_visible
		pass
	pass

func _on_PauseButton_pressed():
	set_visibility(!get_tree().paused)
	get_tree().paused = !get_tree().paused
	pass

func _on_Continue_pressed():
	get_tree().paused = false
	set_visibility(false)
	pass 
