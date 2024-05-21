extends CanvasLayer

var progress: float = 1.0;

func _ready():
	visible = true

func _process(delta):
	progress = move_toward(progress, 0.0, 0.05);
	$ColorRect.modulate.a = progress;
	# Trocar de cena finalmente	
	if progress <= 0.0:
		queue_free()
