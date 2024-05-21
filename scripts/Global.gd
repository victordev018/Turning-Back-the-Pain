extends Node

var levelNode = null
var uiNode = null
var playerNode = null
var fadeInScene = preload("res://scenes/fade_in.tscn")
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
	
	
	
