## Marca o script atual como um tool, permitindo a atualização do sprit dentro do próprio editor em tempo real
@tool 
extends Area2D 

## var de item coletável:
@export var item: InvItem;

func _process(delta):
	get_node("Sprite2D").texture = item.texture;

## quando o player colidir com a maçã:
func _on_body_entered(body):
	if body is Player:
		body.collect(item)
		await get_tree().create_timer(0.1).timeout; # time para o item permanecer
		self.queue_free();
