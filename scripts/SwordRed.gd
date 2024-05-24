extends Area2D

## referência ao sprite da espada flamejante(vermelha)
var swordRed = preload("res://assets/red wooden sword.png");

## ## Acionada quando o body colidir com a espada:
func _on_body_entered(body):
	if body is Player:
		Global.playerNode.spriteSword.texture = swordRed;
		Global.playerNode.BASE_DEMAGE = 2;
		Global.playerNode.damageBuff = true;
		queue_free();

