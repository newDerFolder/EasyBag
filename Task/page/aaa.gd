extends Node


@export var codex:=preload("res://resource/eb/codex.tres")
@export var inventory:=EB_CapacityInventory.new()

func _ready() -> void:
	inventory.stack_attribute=preload("res://resource/eb/late_attribute/stack.gd").new()
	inventory.max_stack_attribute=preload("res://resource/eb/static_attribute/max_stack.gd").new()
	
	var item=codex.get_InventoryItem_by_id("苹果")
	var attribute=item.get_attribute_by_name("stack")
	attribute.set_value(64)
	print(item.has_tag_by_name("food"))
	inventory.add_item(item)
	var drop_pool:EB_DropPool=preload("res://resource/eb/drop_pool/task_drop.tres")
	var drop_item=drop_pool.get_drop()
	inventory.add_item(drop_item)
	
	for i in range(100):
		var new_dItem=drop_pool.get_drop()
		inventory.add_item(new_dItem)
