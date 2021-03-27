extends Control

func _ready():
	$SplashImage.fade_in()
	pass 

func _on_SplashImage_splash_finished():
	$SplashImage.hide()
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	pass # Replace with function body.
