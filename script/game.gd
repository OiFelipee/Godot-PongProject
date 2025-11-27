extends Node2D

#contagem de pontos
@onready var label_pongs = $Pong
@onready var ball = $Ball
@onready var tutorial = $Tutorial
@onready var positions = $Positions
var last_position 
var asteroid_scene = preload("res://scenes/asteroid.tscn")

func _process(_delta: float) -> void:
	
	if ball.started:
		label_pongs.visible = true
		tutorial.visible = false
		
	label_pongs.text = str(ball.pong)


# bolinha saiu, reinicia
func _on_hole_body_entered(_body: Node2D) -> void:
	call_deferred("reload_scene")

func reload_scene():
	get_tree().reload_current_scene()


func _on_timer_spawner_timeout() -> void:
	spawn_asteroid()


func spawn_asteroid():
	if (ball.started):
		var positions_list = positions.get_children()
		var _spawn_position = positions_list.pick_random()
		
		if (_spawn_position != last_position):
			var _asteroid_instance = asteroid_scene.instantiate()
			_asteroid_instance.global_position =  _spawn_position.position
			add_child(_asteroid_instance)
			last_position = _spawn_position
		else:
			spawn_asteroid()
