extends Panel

## referência para o icone do intem:
@onready var icon_visual: Sprite2D = get_node("CenterContainer/Panel/item_icon");

## variável de contorle do texto do amount
@onready var amount_text: Label = get_node("CenterContainer/Panel/Label");

## Variaável que guarda o nome o item que foi selecionado:
var myName = "";

## Variaável que guarda a quantidade do item que foi selecionado:
var myAmount;

func _ready():
	ItemManage.invUiSlot = self;

func _process(delta):
	pass

## função para atualizar o ícone na grade do inventário:
func uppdatIcon(slot: InvSlot) -> void:
	if slot.amount <= 0:
		amount_text.visible = false;
		icon_visual.visible = false;
		$Button.disabled = true;
		return;
	if not slot.item: # se este espaço estiver vazio
		amount_text.visible = false;
		icon_visual.visible = false;	
		$Button.disabled = true
	else:
		myName = slot.item.name;
		myAmount = slot.amount;
		$Button.disabled = false
		icon_visual.visible = true;
		icon_visual.texture = slot.item.texture;
		if slot.amount > 1:
			amount_text.visible = true;
		amount_text.text = str(slot.amount);
			
func clearInventory() -> void:
	var slot = ItemManage.invPlay.slots;
	$Button.disabled = true;
	for i in range(slot.size()):
		slot[i].amount = 0;
		slot[i].item = null
