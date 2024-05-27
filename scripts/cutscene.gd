extends Node2D

var progress: float = 0.0;
var cutsceneTexts: Array[String] = [
	"Todas as cidades contam com heróis escolhidos como seus protetores. ",
	"No entanto, um dia, ocorreu a maior invasão já vista, realizada por monstros de todos os tipos. ",
	"Surpreendidos pelo acontecimento, os guerreiros fizeram o máximo para proteger as cidades e o reino, mas mesmo com todo o seu esforço, não conseguiram." ,
	"Assim, resta apenas um protetor com suas armaduras e armas completamente desgastadas.",
	"Então mesmo com sua esperança ferida, ele decide usar suas últimas forças em uma aposta.",
	"Buscará uma lenda, mesmo sem saber se é real ou não, que diz que uma caverna dominada por demônios e inimigos assustadores possui um item capaz de voltar no tempo." ,
	"Para concluir seu objetivo, ele precisará de muita sorte, habilidade e, principalmente, estratégia...",
]
var page: int = 0;
@onready var cutsceneLabel: Label = get_node("CanvasLayer/Panel/Label");

func _ready() -> void:
	Global.menuMusic.stop();
	Global.initMusic.play();

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
			Global.changeScene("world")


func _on_button_pressed():
	Global.changeScene("world")
