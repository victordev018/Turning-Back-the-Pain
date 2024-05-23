extends Control

## variável que controla a abertura e fechamento do inventário:
var is_open = false; 

#+ pega todos os slot's como um array
@onready var slots: Array = $NinePatchRect/GridContainer.get_children();

func _ready():
	Global.uiInv = self;
	# conectando sinal de update com a função uppdat_alot
	ItemManage.invPlay.update.connect(uppdat_slots);
	uppdat_slots();
	close();
	
## função para atualizar cada slot:
func uppdat_slots():
	for item in range(ItemManage.invPlay.slots.size()):
		slots[item].uppdatIcon(ItemManage.invPlay.slots[item])
		

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
