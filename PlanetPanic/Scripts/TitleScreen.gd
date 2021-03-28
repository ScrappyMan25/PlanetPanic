extends Control

var scene_to_load : PackedScene
var GameScene : PackedScene = preload("res://Scenes/Game_Scene.tscn")

func _ready(): #Looks through all the button exist and load the scene when clicked
	pass # Replace with function body.

#Load scene
func _on_FadeIn_fade_finished(): 
	get_tree().change_scene_to(scene_to_load)
	pass

#Play animation
func _on_Play_pressed() -> void:
	scene_to_load = GameScene
	$FadeIn.show()
	$FadeIn.fade_in()
	pass # Replace with function body.

#Quit Animation
func _on_Quit_pressed() -> void:
	#Wuman to add quit code here
	pass # Replace with function body.
