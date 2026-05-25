extends Node


@export var codex:=preload("res://resource/codex.tres")
@export var inventory:=EB_Inventory.new()

func _ready() -> void:
	var item=codex.get_InventoryItem_by_id("苹果")
	var attribute=item.get_attribute_by_name("stack")
	attribute.set_value(64)
	print(item.has_tag_by_name("food"))
	inventory.add_item(item)
	var drop_pool:EB_DropPool=preload("res://resource/eb/drop_pool/task_drop.tres")
	var drop_item=drop_pool.get_drop()
	inventory.add_item(drop_item)
