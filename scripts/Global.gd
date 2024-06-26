extends Node

## Referências as musicas usadas no jogo.
@onready var menuMusic: AudioStreamPlayer2D = get_node("Musics/menuMusic");
@onready var initMusic: AudioStreamPlayer2D = get_node("Musics/initMusic");
@onready var rainMusic: AudioStreamPlayer2D = get_node("Musics/rainMusic");
@onready var cave1Music: AudioStreamPlayer2D = get_node("Musics/cave1Music");
@onready var cave2Music: AudioStreamPlayer2D = get_node("Musics/cave2Music");
@onready var bossMusic: AudioStreamPlayer2D = get_node("Musics/bossMusic");
@onready var gameWinMusic: AudioStreamPlayer2D = get_node("Musics/gameWinMusic");
@onready var gameOverMusic: AudioStreamPlayer2D = get_node("Musics/gameoverMusic");

## Referência para o nó do nível atual
var levelNode = null
## Referência para o nó da interface do usuário
var uiNode = null
## Referência para o script de ui_inv:
var uiInv = null;
## Referência para o nó do jogador
var playerNode: Player = null
## Carrega a cena de transição de fade-in para ser usada posteriormente
var fadeInScene = preload("res://scenes/fade_in.tscn")
## Posição definida do PLayer ao iniciar a cena
var destinyPosition: Vector2 = Vector2.ZERO
var playerHealth : int = 6
var playerMaxHealth : int = 6
## Dicionário das principais cenas do jogo
var scenes : Dictionary = {
	"title" : preload("res://scenes/title_screen.tscn"),
	"world" : preload("res://scenes/world_1.tscn"),
	"world2": preload("res://scenes/world_2.tscn"),
	"world3" : preload("res://scenes/world_3.tscn"),
	"world4" : preload("res://scenes/world_4.tscn"),
	"gameOver" : preload("res://scenes/game_over.tscn"),
	"cutscene": preload("res://scenes/cutsceneTrue.tscn"),
	"final" : preload("res://scenes/final_scene.tscn")
}

## Transiciona para a cena desejada.
func changeScene(newScene : String):
	var transPatro = fadeInScene.instantiate()
	transPatro.destinyScene = scenes.get(newScene)
	add_child(transPatro)
	
## Função que checa se não há mais nenhum inimigo no mapa, se não tiver ele libera a passagem do portal:
func openDoorIfNoEnemies() -> void:
	var _enemiesNode = levelNode.find_child("Enemies");
	if len(_enemiesNode.get_children()) <= 0:
		var _transportAreas = levelNode.get_node("TransporterAreas");
		for transArea in _transportAreas.get_children():
			transArea.get_child(0).disabled = false;
