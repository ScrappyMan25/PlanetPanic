extends Node

signal GameOver
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_GameOver_finished():
	emit_signal("GameOver")
	pass # Replace with function body.
