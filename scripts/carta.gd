extends Area2D

@onready var carta = $"../UI"


## if player entered carta
func _on_body_entered(body):
	carta.visible = true;
	
