extends Button

## ativando e desativando o butão do slot
func _on_mouse_entered():
	disabled = false;
	
func _on_mouse_exited():
	disabled = true;

## quando alguma caixa do slot for clicada:
func _on_pressed():
	print("cliquei")
