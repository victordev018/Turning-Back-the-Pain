extends Node2D



func _ready():
	Global.levelNode = self;
	
func _process(delta):
	# Se existir um player, posicionar as particles nele
	var _playerPos = Global.playerNode.global_position
	$RainParticles.global_position = Vector2(_playerPos.x, _playerPos.y - 180)
	$RainGroundParticles.global_position = Vector2(_playerPos.x, _playerPos.y)
	pass
	
