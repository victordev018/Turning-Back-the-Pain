extends ProgressBar
class_name StaminaBar

# Variável para armazenar a resistência
var stamina: float = 100.0

func _process(delta):
	var _c = 1.0 - 0.4 * value/max_value
	var col = Color (1.0 - value/max_value, _c, _c * 1.2)
	modulate = col
	
func _ready():
	stamina = 100
	value = stamina
	
func newStaminaBar():
	if stamina >= 0:
		stamina = move_toward(stamina, 0.0,  100.0)
	value = stamina

