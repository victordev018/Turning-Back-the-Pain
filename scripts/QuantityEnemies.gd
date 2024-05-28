extends Node2D

## Variável para acessar o label de quantidade de inimigos
@onready var textLabelEnemy: Label = get_node("PanelText/Label");

func _process(delta) -> void:
	updateLabelQuantityEnemy()
	
## Função para atualizar o label da quantidade de inimigos
func updateLabelQuantityEnemy() -> void:
	if Global.levelNode != null:
		var _enemiesNode = Global.levelNode.find_child("Enemies")
		var _quantityEnemies = len(_enemiesNode.get_children())
		if _quantityEnemies <= 0:
			textLabelEnemy.text = "The portal has been opened!"
			return;
		textLabelEnemy.text ="Enemies: " + str(int(_quantityEnemies));
	
	
