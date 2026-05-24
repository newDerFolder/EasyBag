extends Node


@export var codex:=preload("res://resource/codex.tres")
@export var inventory:=EB_Inventory.new()

func _ready() -> void:
	var item=codex.get_InventoryItem_by_id("苹果")
	var attribute=item.get_attribute_by_name("stack")
	#attribute.set_value(64)
	inventory.add_item(item)
