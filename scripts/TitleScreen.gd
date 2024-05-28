extends Node2D

var appearingProgress: float = 0.0;
@onready var container = get_node("CanvasLayer/VBoxContainer");


func _on_new_game_button_pressed():
	Global.changeScene("cutscene");

func _ready() -> void:
	Global.destinyPosition = Vector2.ZERO
	Global.rainMusic.stop();
	Global.cave1Music.stop();
	Global.cave2Music.stop();
	Global.bossMusic.stop();
	Global.gameOverMusic.stop();
	Global.gameWinMusic.stop();
	Global.menuMusic.play();

func _process(delta):
	container.position.x = lerp(container.position.x, 85.0, 0.05);
	$CaveLight.texture.gradient.colors[0].a = 0.10 + sin(Time.get_ticks_msec()/1000.0) * 0.20
