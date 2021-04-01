extends Node2D

signal asteroid_hit
var GameOver : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite.play("default")
	pass # Replace with function body.

#Signals

func _on_Sun_Area_area_entered(_area: Area2D) -> void:
#	print(_area.get_parent().name)
	_area.get_parent().queue_free()
	$AnimatedSprite.play("Sun_eat")
	$AnimatedSprite.frame = 0
	if "Asteroid" in _area.get_parent().name:
		emit_signal("asteroid_hit")
		$PlanetDestroy.play()
	pass # Replace with function body.

func _on_AnimatedSprite_animation_finished():
#	if $AnimatedSprite.animation != "Sun_Sad":
	if !GameOver:
		$AnimatedSprite.play("default")
	pass # Replace with function body.
