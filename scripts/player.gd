extends CharacterBody2D

## speed player
@export var speed:= 64.0;

## reference animation
@onready var animation := $animation;


func _physics_process(delta: float) -> void:
	movimentar_player(delta)

func movimentar_player(delta) -> void:
	## flip_h
	animation.flip_h = false;
	
	## get direction
	var direction :Vector2 = Vector2(
		Input.get_axis("move_left", "move_rigth"),
		Input.get_axis("move_up", "move_down")
	)
	## applying movement
	velocity = direction.normalized() * speed
	move_and_slide()
	
	## animation player:
	if direction != Vector2.ZERO: # se player estiver correndo
		# verificar se está correndo para esquerda
		if direction.x < 0:
			animation.flip_h = true;
		animation.play("Run")
	else:
		animation.play("Idle")
	







