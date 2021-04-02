extends Node2D

signal asteroid_hit
var GameOver : bool = false

var heat_level : int  = 50

var SunMeterSprites : Dictionary = {
	0: load("res://Assets/Game_Assets/SunMeter/0.png"),
	10: load("res://Assets/Game_Assets/SunMeter/1.png"),
	20: load("res://Assets/Game_Assets/SunMeter/2.png"),
	30: load("res://Assets/Game_Assets/SunMeter/3.png"),
	40: load("res://Assets/Game_Assets/SunMeter/4.png"),
	50: load("res://Assets/Game_Assets/SunMeter/5.png"),
	60: load("res://Assets/Game_Assets/SunMeter/6.png"),
	70: load("res://Assets/Game_Assets/SunMeter/7.png"),
	80: load("res://Assets/Game_Assets/SunMeter/8.png"),
	90: load("res://Assets/Game_Assets/SunMeter/9.png"),
	100: load("res://Assets/Game_Assets/SunMeter/10.png")
}

var FireBallScene : PackedScene = preload("res://Scenes/FireBall.tscn")
var SunMeter : TextureRect
var SoundScene : Node
var Game_Scene : Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SunMeter = get_parent().get_node("UI").get_node("SunMeter")
	SunMeter.texture = SunMeterSprites.get(heat_level)
	Game_Scene = get_parent()
	SoundScene = Game_Scene.get_node("SoundScene")
	$AnimatedSprite.play("default")
	pass # Replace with function body.

func FireBall(I_Pos : Vector2) -> void:
	#Shoot FireBall to I_Pos
	print(I_Pos)
	if heat_level - 10 > 0:
		heat_level -= 10
		SunMeter.texture = SunMeterSprites.get(heat_level - (heat_level%10))
		$AnimatedSprite.play("Sun_Spit")
		var fb = FireBallScene.instance()
		fb.get_node("AnimatedSprite").rotate(position.angle_to_point(I_Pos))
		fb._direction = (I_Pos - position).normalized()
		add_child(fb, true)
	pass

#Signals

func _on_Sun_Area_area_entered(_area: Area2D) -> void:
#	print(_area.get_parent().name)
	if !"FireBall" in _area.get_parent().name:
		_area.get_parent().queue_free()
		$AnimatedSprite.play("Sun_eat")
		$AnimatedSprite.frame = 0
		if "Asteroid" in _area.get_parent().name:
			emit_signal("asteroid_hit")
			SoundScene.get_node("Chomp").play()
			heat_level += 2
			#Update Texture
			if heat_level > 100:
				heat_level = 100
			SunMeter.texture = SunMeterSprites.get(heat_level - (heat_level%10))
	pass # Replace with function body.

func _on_AnimatedSprite_animation_finished():
	if !GameOver:
		$AnimatedSprite.play("default")
	pass # Replace with function body.
