extends Node2D
@onready var enemy = $Enemy
@onready var end_level_timer = $EndLevelTimer

func _process(delta):
	var en = get_node_or_null("Enemy")
	if en != null:
		if en.health <= 0:
			if end_level_timer.is_stopped():
				end_level_timer.start()


func _on_end_level_timer_timeout():
	Global.changeScene("final")
	
func _ready():
	Global.levelNode = self
