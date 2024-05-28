extends Node2D

var damage: int = 0;
var life = 30;
var startPosition = Vector2.ZERO;
# Called when the node enters the scene tree for the first time.
func _ready():
	var labelDamage = get_node("Label") as Label;
	labelDamage.text = "-"+str(damage)
	startPosition = global_position;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.y -= 0.168;
	if life > 0:
		life -= 1;
	else:
		queue_free();
	pass
