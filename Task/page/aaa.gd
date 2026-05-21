extends Node


@export var codex:=preload("res://Task/codex.tres")
@export var inventory:=EB_Inventory.new()

func _ready() -> void:
	var item=codex.get_InventoryItem_by_id("苹果")
	inventory.add_item(item)
