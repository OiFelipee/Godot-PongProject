extends CharacterBody2D

#VARIAVEIS
var started = false 
var start_speed = 500
@export var incremental_speed = 1.02
var angle = [250, -250, 300, -300]
var pong = 0


#se apertou space e a variavel started segue false, o jogo começa
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("Start") and started == false:
		start_game()
	
	# quando começa, usa o move, onde velocidade multiplicada o delta e verifica se a velocidade não é nula, 
	# então rebate a bolinha com bounce, multiplicando o incremental speed para tornar o jogo mais dificil
	if started: 
		var _collision = move_and_collide(velocity*_delta)
		if _collision != null:
			if _collision.get_collider().name == "TopWall":
				pong += 1
				velocity = velocity.bounce(_collision.get_normal()) * incremental_speed
			else:
				velocity = velocity.bounce(_collision.get_normal())
				
# apos space, jogo começa, lança bolinha com velocidade x e -y, com start speed variavel e angulo aleatorio,
func start_game():
	started = true
	velocity.y = -start_speed
	velocity.x = angle.pick_random()
