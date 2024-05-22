extends Node2D

func _ready():
	Global.levelNode = self;
	# Consultar se temos uma posição para atribuir ao Player
	if Global.destinyPosition != Vector2.ZERO:
		$Player.global_position = Global.destinyPosition;
		Global.destinyPosition = Vector2.ZERO;
	
func _process(delta):
	# Se existir um player, posicionar as particles nele
	var _playerPos = Global.playerNode.global_position
	$RainParticles.global_position = Vector2(_playerPos.x, _playerPos.y - 180)
	$RainGroundParticles.global_position = Vector2(_playerPos.x, _playerPos.y)
	
