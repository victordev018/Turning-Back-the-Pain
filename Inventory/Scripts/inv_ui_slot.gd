extends Panel

## referência para o icone do intem:
@onready var icon_visual: Sprite2D = get_node("CenterContainer/Panel/item_icon");

## função para atualizar o ícone na grade do inventário:
func uppdatIcon(item: InvItem) -> void:
		if not item: # se não este espaço estiver vazio
			icon_visual.visible = false;
		else:
			icon_visual.visible = true;
			icon_visual.texture = item.texture;
