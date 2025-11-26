extends Node2D

#contagem de pontos
@onready var label_pongs = $Pong
@onready var ball = $Ball
@onready var tutorial = $Tutorial

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

#spawner
func _on_time_spawner_timeout() -> void:
	spawn_asteroid()

func spawn_asteroid():
	pass
