extends Node

## Referência para o nó do nível atual
var levelNode = null
## Referência para o nó da interface do usuário
var uiNode = null
## Referência para o nó do jogador
var playerNode = null
## Carrega a cena de transição de fade-in para ser usada posteriormente
var fadeInScene = preload("res://scenes/fade_in.tscn")

## Dicionário das principais cenas do jogo
var scenes : Dictionary = {
	"title" : preload("res://scenes/title_screen.tscn"),
	"world" : preload("res://scenes/world_1.tscn"),
	"gameOver" : preload("res://scenes/game_over.tscn")
}

## Transiciona para a cena desejada.
func changeScene(newScene : String):
	var transPatro = fadeInScene.instantiate()
	transPatro.destinyScene = scenes.get(newScene)
	add_child(transPatro)
	
