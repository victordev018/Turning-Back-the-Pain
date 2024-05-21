extends Resource

class_name Inventory;

## swinal para atualizar slot
signal update;

@export var slots: Array[InvSlot];

## função para inserir um novo item no slot:
func insert(item: InvItem) -> void:
	#  items_slots será uma nova lista contendo apenas os elementos de slots onde slot.item é igual a item.
	var items_slots = slots.filter(func(slot): return slot.item == item)
	if !items_slots.is_empty():   # se a lista não estiver vazia
		items_slots[0].amount += 1;
	else:      # para os slots vazios
		var emptyslot = slots.filter(func(slot): return slot.item == null);
		if !emptyslot.is_empty():
			emptyslot[0].item = item;
			emptyslot[0].amount = 1;
	update.emit();  # emitindo sinal
		
