extends Panel

## referência para o icone do intem:
@onready var icon_visual: Sprite2D = get_node("CenterContainer/Panel/item_icon");

## variável de contorle do texto do amount
@onready var amount_text: Label = get_node("CenterContainer/Panel/Label");

## função para atualizar o ícone na grade do inventário:
func uppdatIcon(slot: InvSlot) -> void:
		if not slot.item: # se este espaço estiver vazio
			amount_text.visible = false;
			icon_visual.visible = false;
		else:
			icon_visual.visible = true;
			icon_visual.texture = slot.item.texture;
			if slot.amount > 1:
				amount_text.visible = true;
			amount_text.text = str(slot.amount);
			

