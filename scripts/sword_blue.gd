extends Area2D

## Refência ao sprite da espada azul:
var swordBlue = preload("res://assets/blue wooden sword.png")

## Acionada quando o body colidir com a espada:
func _on_body_entered(body):
	if body is Player:
		Global.playerNode.spriteSword.texture = swordBlue;
		Global.playerNode.BASE_DEMAGE = 1;
		Global.playerNode.damageBuff = true;
		queue_free();
