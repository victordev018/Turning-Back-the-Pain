extends Control

## variável que controla a abertura e fechamento do inventário:
var is_open = false;

## variávris que controla a interface do inventário:
@onready var inv: Inventory = preload("res://Inventory/inventorys/player_inventory.tres");
# pega todos os slot's como um array
@onready var slots: Array = $NinePatchRect/GridContainer.get_children(); 

func _ready():
	# conectando sianal de update com a função uppdat_alot
	inv.update.connect(uppdadat_slots);
	uppdadat_slots();
	close();
	
## função para atualizar cada slot:
func uppdadat_slots():
	for item in range(inv.slots.size()):
		slots[item].uppdatIcon(inv.slots[item])
		

func _process(delta) -> void:
	# se clicar na tecla tab:
	if Input.is_action_just_pressed("inv"): 
		if is_open:  # esta aberta?
			close(); # feche
		else:
			open();  # abra

## função para abrir o inventário:
func open() -> void:
	self.visible = true;
	is_open = true;

## função para fechar o inventário:
func close() -> void:
	self.visible = false;
	is_open = false;
