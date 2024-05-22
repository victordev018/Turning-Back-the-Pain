extends ProgressBar
class_name HealthBar

@onready var timer = $Timer
@onready var damageBar = $DamageBar

var health: int = 100

var approaching = false;

func _process(delta):
	if approaching:
		var _diff = abs(damageBar.value - health);
		var _sp = float(_diff / 10);
		damageBar.value = move_toward(float(damageBar.value), float(health), _sp)
		if _diff < 0.2:
			damageBar.value = health;
			approaching = false;

func setHealth(newHealth):
	var prevHealth = health
	health = min(max_value, newHealth)
	value = health
	
	if health <= 0:
		pass
	if health < prevHealth:
		timer.start()
	else:
		damageBar.value = health
	

func init_health(_health):
	health = _health
	max_value = health
	value = health
	damageBar.max_value = health
	damageBar.value = health

func _on_timer_timeout():
	approaching = true;
