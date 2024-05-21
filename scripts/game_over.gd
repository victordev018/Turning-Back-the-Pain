extends CanvasLayer

func _process(delta):
	pass


func _on_restart_buton_pressed():
	Global.changeScene("world")


func _on_main_menu_buton_pressed():
	Global.changeScene("title")
