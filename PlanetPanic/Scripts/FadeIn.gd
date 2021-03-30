extends ColorRect

signal fade_finished

func fade_in():
	$AnimationPlayer.play("fade_in")#Play animation
	pass

func _on_AnimationPlayer_animation_finished(_anim_name): #Emit signal when animation is finished
	emit_signal("fade_finished")
	pass
