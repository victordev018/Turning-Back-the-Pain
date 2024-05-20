
extends CharacterBody2D
@onready var player = null
@onready var enemy_skeleton = $"."
const SPEED = 60.0
const JUMP_VELOCITY = -400.0

func _ready():
	player = Global.playerNode
	

func _physics_process(delta):
	follow_player(delta)
	move_and_slide()

func _on_hit_box_body_entered(body: Player):
	var _vector = global_position.direction_to(player.global_position);
	body.knockback(_vector)
	body.take_damage()

## Atualiza a velocidade de acordo com a direção do player
func follow_player(delta):
	#global_position = lerp(enemy_skeleton.global_position, player.global_position, 2)
	# TODO: Checar se existe a instancia do player, antes de tentar mover até ele.
	var _vector = global_position.direction_to(player.global_position);
	velocity = _vector * SPEED

