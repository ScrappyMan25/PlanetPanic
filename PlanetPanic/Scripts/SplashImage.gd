extends TextureRect

signal splash_finished

func fade_in():
	$AnimationPlayer.play("FadeOut")
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("splash_finished")
	pass # Replace with function body.
