extends Control

var scene_path_to_load

func _ready():
	for button in $MainMenu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	pass # Replace with function body.


func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()
	pass


func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	pass # Replace with function body.
