extends Node2D

var appearingProgress: float = 0.0;
@onready var container = get_node("CanvasLayer/VBoxContainer");

func _on_new_game_button_pressed():
	Global.changeScene("world")

func _process(delta):
	container.position.x = lerp(container.position.x, 85.0, 0.05);
	$CaveLight.texture.gradient.colors[0].a = 0.10 + sin(Time.get_ticks_msec()/1000.0) * 0.20