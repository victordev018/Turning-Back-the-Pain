extends Node
## classe responsável por gerenciar os itens e suas utilidades.

## variávris que controla a interface do inventário:
@onready var invPlay: Inventory = preload("res://Inventory/inventorys/player_inventory.tres");

## Referência ao tempo de efeito da porção de velocidade:
@onready var timerVelocity :Timer = get_node("Timer");

## Controlador de tempo de velocidade aplicada por porção velocity.
var availableTime : bool = false;

## Dicionario de ações para cada item coletado, por meio de chave (nome do item) e valor (função do item):
var itemsActions: Dictionary = {
	"potionCure": Callable(self, "usePotionCure"),
	"apple": Callable(self, "useApple"),
	"potionVelocity": Callable(self, "usePotionVelocity"),
	"potionForce": Callable(self, "usePotionForce")
}

## função para consumir item.
func useItem(itemKey: String) -> bool:
	## O tipo Callable guarda uma função que pode ser acessada pelo método call().
	var action: Callable = itemsActions.get(itemKey);
	## Verifica se a ação existe e chama a função
	return action.call();

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
	Global.playerNode.speedBuff = true;
	return true;

## Função para aumentar dano da espada:


## função acionada quando consome uma maçã.
func useApple() -> bool:
	print("Comi a maçã!");
	return true;

## Acionada quando o tempo do efeito da porção de velocidade acaba.
func _on_timer_timeout():
	print("Cabou a droga e o dinheiro ._.")
	Global.playerNode.speedBuff = false;

