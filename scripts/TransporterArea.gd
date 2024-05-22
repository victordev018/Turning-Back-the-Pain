@tool
extends Area2D

@export var destinyScene: String = "";
@export var destinyPosition: Vector2 = Vector2.ZERO;

func _process(delta):
	update_configuration_warnings()

func _get_configuration_warnings():
	var warnings = []

	if destinyScene == "":
		warnings.append("Defina a scene destino.")
		
	#if Global.scenes.has(destinyScene):
		#warnings.append("Scene não encontrada no banco de dados de scenes.")

	if destinyPosition == null:
		warnings.append("Certifique-se de adicionar a posição destino.")

	# Returning an empty array means "no warning".
	return warnings

## Acionado quando o Player entra em contato.
func _on_body_entered(body):
	Global.changeScene(destinyScene)
	Global.destinyPosition = destinyPosition;
