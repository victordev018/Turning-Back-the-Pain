extends Panel

## referência para o icone do intem:
@onready var icon_visual: Sprite2D = get_node("CenterContainer/Panel/item_icon");

## variável de contorle do texto do amount
@onready var amount_text: Label = get_node("CenterContainer/Panel/Label");

## Variaável que guarda o nome o item que foi selecionado:
var myId = "";

func _process(delta):
	pass

## função para atualizar o ícone na grade do inventário:
func uppdatIcon(slot: InvSlot) -> void:
	if not slot.item: # se este espaço estiver vazio
		myId = "";
		amount_text.visible = false;
		icon_visual.visible = false;	
		$Button.disabled = true
	else:
		myId = slot.item.name;
		$Button.disabled = false
		icon_visual.visible = true;
		icon_visual.texture = slot.item.texture;
		if slot.amount > 1:
			amount_text.visible = true;
		amount_text.text = str(slot.amount);
			

