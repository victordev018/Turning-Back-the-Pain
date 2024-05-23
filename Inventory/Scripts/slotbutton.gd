extends Button

## Slot guarda o inventário do player.
var slot = ItemManage.invPlay.slots;
## Acionado quando alguma caixa de slot for clicada:
func _on_pressed():
	var nameItem = get_parent().myName;
	print_rich("cliquei no item: [color=orange]", nameItem," amount: ", get_parent().myAmount);
	var result:bool = ItemManage.useItem(nameItem);
	if result:
		removeItem(nameItem);

## Decrementa o item que foi clicado caso o uso tenha sido feito:
func removeItem(nameItem):
	for i in range(slot.size()):
		if (slot[i].item.name == nameItem):
			slot[i].amount -= 1;
			print("amount: ", slot[i].amount)
			#if slot[i].amount <= 0:
				#slot[i].item = null;
				#slot.remove_at(i);
			get_parent().uppdatIcon(slot[i])
			return;
