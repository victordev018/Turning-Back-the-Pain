extends Button

## Acionado quando alguma caixa de slot for clicada:
func _on_pressed():
	print_rich("cliquei no item: [color=orange]", get_parent().myId);
	ItemManager.useItem(get_parent().myId);
