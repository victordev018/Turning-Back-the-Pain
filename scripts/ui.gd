extends CanvasLayer


@export_category("Objects")
@export var label: Label = null;

@onready var canvasLayer = $"."

## array of history:
var history: Array = [
	"Esta é a primeira frase do meu label...",
	"Esta é a segunda frase do meu label...",
	"Esta é a terceira frase do meu label..."
]

## index of label text
var index_label_current = 0;

func _process(delta):
	show_text_label()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		index_label_current += 1;
		show_text_label();
	
func show_text_label() -> void:
	if index_label_current < history.size():
		label.text = history[index_label_current]
	else:
		print("Finisgh History...")
		canvasLayer.visible = false;
		index_label_current = 0;
		
	
