extends Node2D


func _process(delta) -> void:
	if Global.levelNode != null:
		var _enemiesNode = Global.levelNode.find_child("Enemies")
		var _quantityEnemies = len(_enemiesNode.get_children())
		$PanelText/Label.text ="enemies: " + str(int(_quantityEnemies));
	
	
