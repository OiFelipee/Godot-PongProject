extends Area2D

@export var speed = 140
@export var rotation_speed = 1.3
var start_side

func _ready() -> void:
	if (global_position.x > 540):
		start_side = "right"
	else:
		start_side = "left"


 func _process(delta: float) -> void:
	if (start_side == "right"):
		global_position.x -= speed*delta
	elif (start_side == "left"):
		global_position += speed*delta
