
extends CharacterBody2D
@onready var player = null
const SPEED = 60.0;
@onready var sprite_skeleton = $SpriteSkeleton
@onready var healthbar = $HealthBar
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer;
var health : int = 6;

var damage: int = 1;
@onready var healthBar = get_node("HealthBar") as HealthBar
var redAmount: float = 0.0;
var dead = false

func _ready():
	player = Global.playerNode
	healthbar.init_health(health)

func _physics_process(delta):
	follow_player(delta)
	move_and_slide()
	
func _process(delta):
	if velocity.x > 0:
		sprite_skeleton.flip_h = false
	elif velocity.x < 0:
		sprite_skeleton.flip_h = true
	state_machine()
	
## Atualiza a velocidade de acordo com a direção do player
func follow_player(delta):
	# TODO: Checar se existe a instancia do player, antes de tentar mover até ele.
	var _distance = global_position.distance_to(player.global_position);
	var _vector = global_position.direction_to(player.global_position);
	
	if _distance >= 36:
		velocity = _vector * SPEED;
	elif _distance >= 12:
		if $AttackTimer.is_stopped():
			$AttackTimer.start()
	else:
		velocity = Vector2.ZERO;
	
	var _ang = _vector.angle()
	#_ang = rad_to_deg(_ang);
	$SwordNode.rotation = _ang;
	
	

func state_machine():
	var state = "Idle";
	if velocity.length() > 0:
		state = "Run";
	sprite_skeleton.play(state);


func takeDamage(amount):
	print("[ENEMY] - Dano recebido: %s." % [amount])
	health -= amount;
	healthBar.setHealth(health);
	redAmount = 1.0;
	dead = health <= 0;


func _on_hurt_box_area_entered(area):
	if area.name == "HitBoxPlayer":
		print("Enemy encostou numa hitbox.")
		var _player: Player = area.get_parent().get_parent();
		var _dmg = _player.damage;
		takeDamage(_dmg)

func attack():
	animationPlayer.play("Attack")

func _on_attack_timer_timeout():
	attack()
	pass # Replace with function body.
