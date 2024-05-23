extends CharacterBody2D
class_name Player

## inventário do player:
@export_category("Player settings")
@export var inv: Inventory;
@onready var animation = $Animation
## Referência aos labels de tempo de velocity e força:
@onready var time_velocity_label = $Panels/TimeVelocity
@onready var time_force_label = $Panels/TimeForce
## Movimentação do Player
## Capacidade do player usar o rolamento
var rolling : bool = false
var canRoll = true
var BASE_SPEED: float = 100;
var _move_speed: float = BASE_SPEED;
var speedBuff: bool = false;
var _friction : float = 0.8;
var _acceleration: float = 0.4;
var _direction : Vector2 = Vector2();
## Referência do nó da Espada
@onready var mySword = get_node("SwordNode")
## Ddamage do player.
const BASE_DEMAGE: int = 1;
var damage: int = BASE_DEMAGE;
var damageBuff: bool = false;
var facing : int = 1;
var mpos: Vector2 = Vector2.ZERO
var health = 6
var knockbackVector = Vector2.ZERO;
@onready var enemy_skeleton = null
@onready var otherHand = get_node("Animation/Hand");
@onready var healthBar = get_node("Panels/HealthBar") as HealthBar
var dead = false;

# Camera variables
@export var camera_limit := Vector2(1000, 1000);
@onready var camera: Camera2D = get_node("Camera")



## Valor da intensidade do tom vermelho do Player, aumentado ao levar dano.
var redAmount: float = 0.0;

func _ready():
	## Desativando visibilidade dos labels de time veloicy e time force:
	time_velocity_label.visible = false;
	time_force_label.visible = false;
	speedBuff = !ItemManage.timerVelocity.is_stopped();
	Global.playerNode = self;
	set_process(true);
	health = Global.playerHealth;
	healthBar.init_health(health)
	# Definir limites da camera
	camera.limit_left = 0;
	camera.limit_top = 0;
	camera.limit_right = camera_limit.x;
	camera.limit_bottom = camera_limit.y;
	

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
	var _canMove: bool = !Global.uiNode.visible && !dead;
	rolling = $AnimationPlayer.current_animation in ["RollRight", "RollLeft"]
	if _canMove:
		_move()
		move_and_slide()
	else:
		velocity = Vector2.ZERO;
	if rolling:
		velocity = _direction * _move_speed * 4
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
	## aumenta a velocidade de caso tenha usado a porção velocity
	_move_speed = BASE_SPEED + 50 * int(speedBuff);
	## altera a força do damage caso tenha usado a porção de força:
	damage = BASE_DEMAGE + 1 * int(damageBuff);
	Global.playerHealth = health
	state_machine()
	mpos = get_global_mouse_position();
	manageFacing()
	manageSword()
	updatLabelVelocity();
	updatLabelForce();
	
	# Regular tom vermelho
	$Animation.modulate.g = 1.0 - redAmount;
	$Animation.modulate.b = 1.0 - redAmount;
	redAmount = move_toward(redAmount, 0.0, 0.0250);
	
	# Atacar se pressionar boyão direito do mouse, não estiver rolando e o inventário não estiver aberto.
	if Input.is_action_just_pressed("attack") and !rolling and !Global.uiInv.is_open:
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
	if dead: otherHand.position.y = 12;

	if dead:
		$SwordNode.visible = false;
		velocity = Vector2.ZERO
		await  get_tree().create_timer(1).timeout
		Global.changeScene("gameOver")

func state_machine():
	if dead:
		animation.play("Death")
		return
	var state = "Idle"
	if _direction != Vector2.ZERO:
		state = "Run"
	if animation.name != state:
		animation.play(state)

func _on_roll_recovery_timer_timeout():
	canRoll = true

func knockback(_knockbackDirection):
	print("+1 hit")
	knockbackVector = _knockbackDirection * _move_speed * 50;


## verifica se a animação atual é a roll:
func animation_is_roll():
	var animation_player = $AnimationPlayer
	# se aanimação atual for alguma roll
	if animation_player.current_animation in ["RollRight", "RollLeft"]:
		return true;
	return false;

## função de coleta de item:	redAmount = move_toward(redAmount, 0.0, 0.0250);
func collect(item):
	inv.insert(item);

## Reduz uma quantidade de HP
func takeDamage(amount):
	print("[PLAYER] - Dano recebido: %s." % [amount])
	health -= amount;
	updateHealth()
	redAmount = 1.0;
	dead = health <= 0;

func _on_hurt_box_area_entered(area):
	if area.name == "HitBox" or area.name == "HitBox2":
		print("Player encostou numa hitbox.")
		# TODO: Obter valor de [damage] a partir do Node do Esqueleto.
		# var _dmg = area.get_parent().damage;
		var _dmg = 1;
		takeDamage(_dmg)

## Função para atualizar a vida no HealthBar.
func updateHealth() -> void:
	healthBar.setHealth(health)

## Função para atualizar o label do time velocity
func updatLabelVelocity() -> void:
	if ItemManage.availableTimeVelocity:
		time_velocity_label.text = "Timer velocity: "+ str(int(ItemManage.timerVelocity.time_left));
	
func updatLabelForce() -> void:
	if ItemManage.availableTimeForce:
		time_force_label.text = "Timer force: "+ str(int(ItemManage.timerForce.time_left));
	
