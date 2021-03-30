extends Control

var select = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Restart_pressed():
	$Select.play()
	select = 1
	pass # Replace with function body.


func _on_Main_pressed() -> void:
	$Select.play()
	select = 2
	pass # Replace with function body.


func _on_Exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_Select_finished():
	if select == 1:
		var err = get_tree().change_scene("res://Scenes/Game_Scene.tscn")
		if err:
			print(err)
	elif select == 2:
		var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
		if err:
			print(err)
	pass # Replace with function body.
