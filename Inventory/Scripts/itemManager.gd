extends Node
## classe responsável por gerenciar os itens e suas utilidades.

## Dicionario de ações para cada item coletado, por meio de chave (nome do item) e valor (função do item):
var itemsActions: Dictionary = {
	"potion": func(): usePortion(),
	"apple": func(): useApple()
}

## função para consumir item.
func useItem(itemKey: String) -> void:
	## O tipo Callable guarda uma função que pode ser acessada pelo método call().
	var action: Callable = itemsActions.get(itemKey);
	action.call()
	
## função acionada quando consome uma porção.
func usePortion() -> bool:
	print("Usei a porção!");
	return true;

## função acionada quando consome uma maçã.
func useApple() -> bool:
	print("Comi a maçã!");
	return true;
