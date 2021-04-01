extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	#Assign Area to Var
	area2d = $Asteroid_Area
	var spriteType : String = ((randi() % 6) + 1) as String 
	$AnimatedSprite.play(spriteType)
	
	#Connect Signal
	_connectAreaSignal()
	pass # Replace with function body.
