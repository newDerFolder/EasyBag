extends Control

@export var inv:EB_Inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	inv=EB_Inventory.new()
	$PanelContainer/EB_InventoryNode.inventory=inv
	var apple:=load("res://resource/eb/item/apple.tres").duplicate(true)
	apple.stack=5
	inv.add_item(apple)
	var apple2=load("res://resource/eb/item/apple.tres").duplicate(true)
	apple2.stack=2
	inv.add_item(apple2)
	var coco=load("res://resource/eb/item/folder.tres")
	inv.add_item(coco)
	var gun=load("res://resource/eb/item/gun.tres")
	inv.add_item(gun)
	#inv.check_items()
	$PanelContainer/EB_InventoryNode.refresh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
