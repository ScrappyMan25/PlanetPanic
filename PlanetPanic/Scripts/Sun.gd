extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_Sun_Area_area_entered(_area: Area2D) -> void:
	print(_area.get_parent().name)
	if "Asteroid" in _area.get_parent().name:
		_area.get_parent().queue_free()
	pass # Replace with function body.
