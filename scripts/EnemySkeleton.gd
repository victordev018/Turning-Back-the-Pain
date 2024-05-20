extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
	# Add the gravity.
	
	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
