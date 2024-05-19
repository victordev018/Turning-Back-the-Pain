extends Area2D



## if player entered interface
func _on_body_entered(body):
	## reference of interface node
	var interface = Global.uiNode;
	interface.visible = true;
	
