extends CanvasLayer

var destinyScene: PackedScene = null
var progress: float = 0.0;

func _process(delta):
	progress = move_toward(progress, 1.0, 0.05);
	$ColorRect.modulate.a = progress;
	# Trocar de cena finalmente	
	if progress >= 1.0:
		get_tree().change_scene_to_packed(destinyScene)
		queue_free()
