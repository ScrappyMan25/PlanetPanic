extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	set_visibility(false)
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		set_visibility(!get_tree().paused)
		get_tree().paused = !get_tree().paused
	pass


func _on_Continue_pressed():
	get_tree().paused = false
	set_visibility(false)
	pass # Replace with function body.
	
func set_visibility(is_visible):
	for node in get_children():
		node.visible = is_visible
		pass
	pass

