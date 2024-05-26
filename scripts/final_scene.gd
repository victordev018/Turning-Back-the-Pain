extends Node2D

var progress: float = 0.0;
var cutsceneTexts: Array[String] = [
	"O Guerreiro conseguiu cumprir seu objetivo!",
	"Parabéns! Você conseguiu recuperar seu reino :) "
]
var page: int = 0;
@onready var cutsceneLabel: Label = get_node("CanvasLayer/Panel/Label");

func _ready() -> void:
	Global.bossMusic.stop();
	Global.gameWinMusic.play();

func _process(delta):
	progress = move_toward(progress, 1.0, 0.0168/2);
	cutsceneLabel.visible_ratio = progress;
	cutsceneLabel.text = cutsceneTexts[page];
	
	if Input.is_action_just_pressed("attack"):
		if progress < 1.0:
			progress = 1.0;
			return;
			
		if page < len(cutsceneTexts) - 1:
			page += 1;
			progress = 0.0;
		else:
			# Cutscene acabou. Migrar para jogo.
			Global.changeScene("title")


func _on_button_pressed():
	Global.changeScene("title")
