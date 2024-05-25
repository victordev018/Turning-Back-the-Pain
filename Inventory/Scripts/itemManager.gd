extends Node
## classe responsável por gerenciar os itens e suas utilidades.

## informações do inimigo que acabou de morrer:
var nameEnemy: String
var positionDeath: Vector2

## variávris que controla a interface do inventário:
@onready var invPlay: Inventory = preload("res://Inventory/inventorys/player_inventory.tres");

## Referência ao tempo de efeito da porção de velocidade:
@onready var timerVelocity :Timer = get_node("TimerVelocity");

## Referência ao tempo de efeito da porção de força:
@onready var timerForce :Timer = get_node("TimerForce");

## Controlador de tempo de velocidade aplicada por porção velocity.
var availableTimeVelocity : bool = false;

## Controlador de tempo de velocidade aplicada por porção velocity.
var availableTimeForce : bool = false;

## Referência ao nó de inv_ui_slot:
var invUiSlot = null;

## Refeência ao player:
var player = Global.playerNode;

## Dicionario de ações para cada item coletado, por meio de chave (nome do item) e valor (função do item):
var itemsActions: Dictionary = {
	"potionCure": Callable(self, "usePotionCure"),
	"apple": Callable(self, "useApple"),
	"potionVelocity": Callable(self, "usePotionVelocity"),
	"potionForce": Callable(self, "usePotionForce"),
	"swordBlue": Callable(self, "useSwordBlue")
}

## Dicionário de itemns dropáveis para cada inimigo.
var dropItemEnemy: Dictionary = {
	"enemy1" : Callable(self, "dropPotionCure"),
	"enemy2" : Callable(self, "dropPotionVelocity"),
	"enemy3" : Callable(self, "dropPotionForce")
}


## Função para instanciar um novo tem na cena.
func dropItem() -> void:
	var function: Callable = dropItemEnemy.get(nameEnemy);
	function.call();

## função para dropar porção de cura:
func dropPotionCure() -> void:
	var potionCure = preload("res://Inventory/collectibles/ItemAreaPotionCure.tscn");
	var potionInstance = potionCure.instantiate()
	potionInstance.position = positionDeath;
	add_child(potionInstance);
	
## função para dropar porção de Velocity:
func dropPotionVelocity() -> void:
	var potionVelocity = preload("res://Inventory/collectibles/ItemAreaPotionVelocity.tscn");
	var potionInstance = potionVelocity.instantiate()
	potionInstance.position = positionDeath;
	add_child(potionInstance);
	
## função para dropar porção de Força:
func dropPotionForce() -> void:
	var potionForce = preload("res://Inventory/collectibles/ItemAreaPotionForce.tscn");
	var potionInstance = potionForce.instantiate()
	potionInstance.position = positionDeath;
	add_child(potionInstance);
	
## função para consumir item.
func useItem(itemKey: String) -> bool:
	## O tipo Callable guarda uma função que pode ser acessada pelo método call().
	var action: Callable = itemsActions.get(itemKey);
	## Verifica se a ação existe e chama a função
	return action.call();

## Função para mudar a espada e aplicar as novas propiedades dela.
func useSwordBlue() -> bool:
	## Refência ao sprite da espada azul:
	var swordBlue = preload("res://assets/blue wooden sword.png")
	Global.playerNode.spriteSword.texture = swordBlue;
	Global.playerNode.BASE_DEMAGE = 1;
	Global.playerNode.damageBuff = true;
	return false;

## função acionada quando consome uma porção de cura.
func usePotionCure() -> bool:
	if Global.playerNode.health < Global.playerMaxHealth:
		Global.playerNode.health = min(Global.playerNode.health+2, Global.playerMaxHealth);
		Global.playerNode.updateHealth();
		return true;
	return false;

## Função para aumantar a velocidade em 50%.
func usePotionVelocity() -> bool:
	if Global.playerNode.speedBuff:
		return false;
	timerVelocity.start();
	availableTimeVelocity = true;
	Global.playerNode.time_velocity_label.visible = true;
	Global.playerNode.speedBuff = true;
	return true;

## Função para aumentar dano da espada:
func usePotionForce() -> bool:
	if Global.playerNode.damageBuff:
		return false;
	timerForce.start();
	availableTimeForce = true;
	Global.playerNode.time_force_label.visible = true;
	Global.playerNode.damageBuff = true;
	return true;
	
## Funão para mudar a espada atual para a espada de diamante azul:
func changeToSwordBlue() -> bool:
	## muda a textura da espada pra a espada azul
	Global.playerNode.spriteSword.texture = Global.playerNode.swordBlues.texture;
	Global.playerNode.damageBuff = true;
	return true;
	
	

## função acionada quando consome uma maçã.
func useApple() -> bool:
	print("Comi a maçã!");
	return true;

## Acionada quando o tempo do efeito da porção de velocidade acaba.
func _on_timer_timeout():
	availableTimeVelocity = false;
	Global.playerNode.time_velocity_label.visible = false;
	Global.playerNode.speedBuff = false;

## Acionada quando o tempo do efeito de força na espada acaba.
func _on_timer_force_timeout():
	availableTimeForce = false;
	Global.playerNode.time_force_label.visible = false;
	Global.playerNode.damageBuff = false;
