
extends CharacterBody2D
@onready var player = null
const SPEED = 60.0
@onready var sprite_skeleton = $SpriteSkeleton
var enemyLife = 3
var knockbackVector : Vector2 = Vector2.ZERO

func _ready():
	player = Global.playerNode
	pass

func _physics_process(delta):
	#follow_player(delta)
	move_and_slide()
	
func _process(delta):
	if velocity.x > 0:
		sprite_skeleton.flip_h = false
	elif velocity.x < 0:
		sprite_skeleton.flip_h = true
	state_machine()
	
func _on_hit_box_body_entered(body: Player):
	var _vector = global_position.direction_to(player.global_position);
	body.knockback(_vector);
	body.take_damage();

## Atualiza a velocidade de acordo com a direção do player
func follow_player(delta):
	#global_position = lerp(enemy_skeleton.global_position, player.global_position, 2)
	# TODO: Checar se existe a instancia do player, antes de tentar mover até ele.
	var _vector = global_position.direction_to(player.global_position);
	velocity = _vector * SPEED;

func state_machine():
	var state = "Idle";
	if enemyLife <= 0:
		state = "Death";
		sprite_skeleton.play("Death");
		await sprite_skeleton.animation_finished();
		queue_free();
	elif velocity.length() > 0:
		state = "Run";
	sprite_skeleton.play(state);

func knockback(_knockbackDirection):
	print("+1 hit")
	knockbackVector = _knockbackDirection * SPEED * 50;
	
func take_damage():
		print("-1 in life")
		enemyLife -= 1
