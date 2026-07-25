class_name EB_StackItem extends EB_InventoryItem

@export var stack:=1
@export var max_stack:=64

func set_item_stack(value:int):
	stack=value

func get_item_max_stack() -> int:
	return max_stack

func get_item_stack() -> int:
	return stack
