extends Node
## classe responsável por gerenciar os itens e suas utilidades.

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
	"swordBlue": Callable(self, "useSwordBlue"),
	"swordRed": Callable(self, "useSwordRed")
}

## Dicionário de itemns dropáveis para cada inimigo.
var enemyDropItems: Dictionary = {
	"enemy1" : "potionCure",
	"enemy2" : "potionVelocity",
	"enemy3" : "potionForce",
	"enemy4" : "swordBlue",
	"enemy5" : "swordRed",
}

var itemsDatabase: Dictionary = {
	"potionCure": preload("res://Inventory/collectibles/ItemAreaPotionCure.tscn"),
	"potionVelocity": preload("res://Inventory/collectibles/ItemAreaPotionVelocity.tscn"),
	"potionForce": preload("res://Inventory/collectibles/ItemAreaPotionForce.tscn"),
	"swordBlue": preload("res://Inventory/collectibles/itemAreaSwordBlue.tscn"),
	"swordRed": preload("res://Inventory/collectibles/itemAreaSwordRed.tscn")
}


## Função para instanciar um novo tem na cena.
func spawnDroppedItem(_pos, _itemKey) -> void:
	var _itemScene = itemsDatabase.get(_itemKey) as PackedScene;
	var _item = _itemScene.instantiate();
	_item.global_position = _pos;
	Global.levelNode.add_child(_item);
	print("Item %s adicionado na posição %s." % [_itemKey, _pos])
	
## função para consumir item.
func useItem(itemKey: String) -> bool:
	## O tipo Callable guarda uma função que pode ser acessada pelo método call().
	var action: Callable = itemsActions.get(itemKey);
	## Verifica se a ação existe e chama a função
	return action.call();

## Função para mudar a espada atual para a blue e aplicar suas propriedades
func useSwordBlue() -> bool:
	## Refência ao sprite da espada azul:
	var swordBlue = preload("res://assets/blue wooden sword.png")
	Global.playerNode.spriteSword.texture = swordBlue;
	Global.playerNode.BASE_DEMAGE = 1;
	Global.playerNode.damageBuff = true;
	return false;

## Função para mudar a espada atual para a red e aplicar suas propriedades
func useSwordRed() -> bool:
	## referência ao sprite da espada flamejante(vermelha)
	var swordRed = preload("res://assets/red wooden sword.png");
	Global.playerNode.spriteSword.texture = swordRed;
	Global.playerNode.BASE_DEMAGE = 2;
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
