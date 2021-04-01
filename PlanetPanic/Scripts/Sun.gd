extends Node2D

signal asteroid_hit
var GameOver : bool = false

var heat_level : int  = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.play("default")
	pass # Replace with function body.

func FireBall(I_Pos : Vector2) -> void:
	#Shoot FireBall to I_Pos
	print(I_Pos)
	pass

#Signals

func _on_Sun_Area_area_entered(_area: Area2D) -> void:
#	print(_area.get_parent().name)
	_area.get_parent().queue_free()
	$AnimatedSprite.play("Sun_eat")
	$AnimatedSprite.frame = 0
	if "Asteroid" in _area.get_parent().name:
		emit_signal("asteroid_hit")
		$PlanetDestroy.play()
		heat_level += 10
		if heat_level == 100:
			#GAME OVER
			pass
	pass # Replace with function body.

func _on_AnimatedSprite_animation_finished():
#	if $AnimatedSprite.animation != "Sun_Sad":
	if !GameOver:
		$AnimatedSprite.play("default")
	pass # Replace with function body.
