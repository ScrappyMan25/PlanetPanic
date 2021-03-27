extends Node2D

export (int) var Speed
export (int) var Radius

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Planet.position.x = Radius
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += Speed * delta
	pass
