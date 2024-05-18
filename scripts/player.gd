extends CharacterBody2D

@onready var animation = $Animation
## Movimentação do Player
var _move_speed: float = 100
var _friction : float = 0.8
var _acceleration: float = 0.4
var _direction : Vector2 = Vector2()
## Referência do nó da Espada
@onready var mySword = get_node("SwordNode")
## Direção do Player
var facing : int = 1
var mpos: Vector2 = Vector2.ZERO

func _ready():
	set_process(true)
	
## Ajustar direção para onde o Player está olhando.
func manageFacing():
	# Saber para onde o player deve olhar: esquerda ou direita
	var _newFacing = sign(mpos.x - position.x)
	facing = _newFacing if _newFacing != 0 else facing
	
func manageSword():
	# Ajustar escala do player conforme o facing
	mySword.scale.x = facing
	# Apontar a espada
	mySword.look_at(mpos)
	mySword.rotation = mySword.rotation - 280.0 * int(facing < 0)
	
	# Apontar Player
	$Animation.scale.x = facing;
	$RollSprite.scale.x = facing;
	
func _physics_process(delta):
	_move()
	move_and_slide()
	state_machine()
	
func _move() -> void:
	_direction = Vector2(
		Input.get_axis("move_left", "move_rigth"),
		Input.get_axis("move_up", "move_down")
	)
	if _direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
func _process(delta):
	mpos = get_global_mouse_position();	
	manageFacing()
	manageSword()

	# Atacar 
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play("Attack")
		
	# Rolar
	if Input.is_action_just_pressed("roll"):
		var _rollAnimation = "RollRight" if facing > 0 else "RollLeft"
		
		$AnimationPlayer.play(_rollAnimation)

func state_machine():
	var state = "Idle"
	if _direction.x > 0 or _direction.x < 0:
		state = "Run"
	if animation.name != state: 
		animation.play(state)
	
