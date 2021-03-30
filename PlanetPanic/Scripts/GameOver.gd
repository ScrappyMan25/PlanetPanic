extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Restart_pressed():
	var err = get_tree().change_scene("res://Scenes/Game_Scene.tscn")
	if err:
		print(err)
	pass # Replace with function body.


func _on_Main_pressed() -> void:
	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	if err:
		print(err)
	pass # Replace with function body.


func _on_Exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
