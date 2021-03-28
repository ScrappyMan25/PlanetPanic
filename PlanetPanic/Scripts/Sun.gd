extends Node2D

signal asteroid_hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _on_Sun_Area_area_entered(_area: Area2D) -> void:
	if "Asteroid" in _area.get_parent().name:
		_area.get_parent().queue_free()
		emit_signal("asteroid_hit")
	pass # Replace with function body.
