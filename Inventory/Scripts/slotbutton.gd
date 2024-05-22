extends Button

## Acionado quando alguma caixa de slot for clicada:
func _on_pressed():
	print("cliquei no item: ", get_parent().myId);
	ItemManager.useItem(get_parent().myId);
