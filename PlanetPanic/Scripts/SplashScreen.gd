extends Control

func _ready():
	$SplashImage.fade_in()#Play the fade in animation on ready
	pass 

func _on_SplashImage_splash_finished(): #when animation is fnished. Hide the image and change the scene to TitleScreen scene
	$SplashImage.hide()
	var err = get_tree().change_scene("res://Scenes/TitleScreen.tscn")
	if err:
		print(err)
	pass
