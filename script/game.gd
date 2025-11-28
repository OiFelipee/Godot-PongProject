extends Node2D

#contagem de pontos
@onready var label_pongs = $Pong
@onready var ball = $Ball
@onready var tutorial = $Tutorial
@onready var positions = $Positions
@onready var background: Sprite2D = $Background

var last_position 
var asteroid_scene = preload("res://scenes/asteroid.tscn")

var resource_asteroids = {}
var resource_background = {}
var resource_color_label = {}

var new_asteroid_color

func _ready() -> void:
	preload_resources()

func _process(_delta: float) -> void:
	
	if ball.started:
		label_pongs.visible = true
		tutorial.visible = false
		check_pongs(ball.pong)
		
	label_pongs.text = str(ball.pong)

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
			if new_asteroid_color != null:
				_asteroid_instance.get_node("Sprite2D").texture = new_asteroid_color
			add_child(_asteroid_instance)
			last_position = _spawn_position
		else:
			spawn_asteroid()

func preload_resources():
	resource_asteroids = {
		"asteroid1" = preload("res://sprites/Asteroide1.png"),
		"asteroid2" = preload("res://sprites/Asteroide2.png"),
		"asteroid3" = preload("res://sprites/Asteroide3.png"),
		"asteroid4" = preload("res://sprites/Asteroide4.png"),
		"asteroid5" = preload("res://sprites/Asteroide5.png"),
		"asteroid6" = preload("res://sprites/Asteroide6.png"),
	}
	resource_background = {
		"background1": preload("res://sprites/Fundo1.png"),
		"background2": preload("res://sprites/Fundo2.png"),
		"background3": preload("res://sprites/Fundo3.png"),
		"background4": preload("res://sprites/Fundo4.png"),
		"background5": preload("res://sprites/Fundo5.png"),
		"background6": preload("res://sprites/Fundo6.png"),
	}
	resource_color_label = {
		"color1": "7301ec",
		"color2":"4196ff",
		"color3":"4ea771",
		"color4":"fe9c35",
		"color5":"ff5d5d",
		"color6":"762d79",
	}

func check_pongs(pong):
	match pong:
		0:
			update_colors("color1", "background1")
		10:
						update_colors("color2", "background2")
						uptade_asteroids("asteroid2")
		20:
						update_colors("color3", "background3")
						uptade_asteroids("asteroid3")
		30:
						update_colors("color4", "background4")
						uptade_asteroids("asteroid4")
		40:
						update_colors("color5", "background5")
						uptade_asteroids("asteroid5")
		50:
						update_colors("color6", "background6")
						uptade_asteroids("asteroid6")

func update_colors(key_color_label, key_color_bg):
	label_pongs.label_settings.font_color = resource_color_label[key_color_label]
	background.set_texture(resource_background[key_color_bg])

func uptade_asteroids(key_asteroids):
	var asteroids = get_tree().get_nodes_in_group("asteroids")
	
	for asteroid in asteroids:
		asteroid.get_node("Sprite2D").texture = resource_asteroids[key_asteroids]
	
	new_asteroid_color = resource_asteroids[key_asteroids]
