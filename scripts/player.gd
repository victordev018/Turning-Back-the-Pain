extends CharacterBody2D
class_name Player

## inventário do player:
@export_category("Player settings")
@export var inv: Inventory;
@onready var animation = $Animation
## Movimentação do Player
## Capacidade do player usar o rolamento
var rolling : bool = false
var canRoll = true
var _move_speed: float = 100
var _friction : float = 0.8
var _acceleration: float = 0.4
var _direction : Vector2 = Vector2()
## Referência do nó da Espada
@onready var mySword = get_node("SwordNode")
## Direção do Player
var facing : int = 1
var mpos: Vector2 = Vector2.ZERO
var playerLife = 3
var knockbackVector = Vector2.ZERO;
@onready var enemy_skeleton = null


@onready var otherHand = get_node("Animation/Hand");

func _ready():
	Global.playerNode = self
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
	var _canMove: bool = !Global.uiNode.visible;
	rolling = $AnimationPlayer.current_animation in ["RollRight", "RollLeft"]
	if _canMove:
		_move()
		move_and_slide()
	else:
		velocity = Vector2.ZERO;
	if rolling:
		velocity = _direction * _move_speed * 2
	# Desativar colisão ao rolar. TODO..alterar para hurt box! S2
	var my_coll = get_node("HurtBox/Collision") as CollisionShape2D
	my_coll.disabled = rolling

func _move() -> void:
	var _sp = knockbackVector.length() * 0.80;
	knockbackVector = knockbackVector.move_toward(Vector2.ZERO, _sp)

	if !rolling:
		_direction = Vector2(
			Input.get_axis("move_left", "move_rigth"),
			Input.get_axis("move_up", "move_down")
		)

	if _direction != Vector2.ZERO or knockbackVector.length() <= 0:
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return

	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	velocity += knockbackVector

func _process(delta):
	state_machine()
	mpos = get_global_mouse_position();
	manageFacing()
	manageSword()
	# Atacar
	if Input.is_action_just_pressed("attack") and !rolling:
		$AnimationPlayer.play("Attack")

	# Rolar
	if Input.is_action_just_pressed("roll") and canRoll:
		canRoll = false
		$RollRecoveryTimer.start()
		var _rollAnimation = "RollRight" if facing > 0 else "RollLeft"
		$AnimationPlayer.play(_rollAnimation)

	# Mexer a mãozinha avulsa
	var _ang = Time.get_ticks_msec() / 200.0
	otherHand.position.y = 7 + sin(_ang) * 1.25;

	if playerLife <= 0:
		animation.play("Death")
		Global.changeScene("gameOver")

func state_machine():
	var state = "Idle"
	if velocity.length() > 0:
		state = "Run"
	if animation.name != state:
		animation.play(state)

func _on_roll_recovery_timer_timeout():
	canRoll = true

func knockback(_knockbackDirection):
	print("+1 hit")
	knockbackVector = _knockbackDirection * _move_speed * 50;

func take_damage():
	if not animation_is_roll():
		print("-1 in life")
		playerLife -= 1

## verifica se a animação atual é a roll:
func animation_is_roll():
	var animation_player = $AnimationPlayer
	# se aanimação atual for alguma roll
	if animation_player.current_animation in ["RollRight", "RollLeft"]:
		return true;
	return false;

## função de coleta de item:
func collect(item):
	inv.insert(item);
