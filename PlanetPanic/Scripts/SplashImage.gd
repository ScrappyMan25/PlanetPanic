extends TextureRect

signal splash_finished

func fade_in(): #Play Fade_out animation
	$AnimationPlayer.play("FadeOut")
	pass


func _on_AnimationPlayer_animation_finished(_anim_name):#emit signal to say animation is fnished
	emit_signal("splash_finished")
	pass
