extends Interactable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Assign Area to Var
	area2d = $SpeedUpOrbit_Area
	
	#Connect Signal
	_connectAreaSignal()
	pass # Replace with function body.
