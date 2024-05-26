extends Node2D

func _ready():
	Global.menuMusic.stop();
	Global.rainMusic.play();
	Global.levelNode = self;
	# Consultar se temos uma posição para atribuir ao Player
	if Global.destinyPosition != Vector2.ZERO:
		var pl = find_child("Player")
		if pl != null:
			pl.global_position = Global.destinyPosition;
			Global.destinyPosition = Vector2.ZERO;
	 
func _process(delta):
	#Se existir um player, posicionar as particles nele
	if find_child("RainParticles") != null:
		var _playerPos = Global.playerNode.global_position
		$RainParticles.global_position = Vector2(_playerPos.x, _playerPos.y - 180)
		$RainGroundParticles.global_position = Vector2(_playerPos.x, _playerPos.y)
