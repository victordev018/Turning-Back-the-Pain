extends CharacterBody2D

## Referência do nó da Espada
@onready var mySword = get_node("SwordNode")
## Direção do Player
var facing : int = 1
var mpos: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

func _ready():
	set_process(true)
	
func _draw():
	pass

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

func _process(delta):
	mpos = get_global_mouse_position();	
	manageFacing()
	manageSword()

	# Atacar 
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$AnimationPlayer.play("Attack")
		
	# Rolar
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var _rollAnimation = "RollRight" if facing > 0 else "RollLeft"
		$AnimationPlayer.play(_rollAnimation)



