extends Area2D


## var de item coletável:
@export var item: InvItem;

## quando o player colidir com a maçã:
func _on_body_entered(body):
	if body is Player:
		body.collect(item)
		await get_tree().create_timer(0.1).timeout; # time para a maçã permanecer
		self.queue_free();
