extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var inv=EB_Inventory.new()
	$PanelContainer/EB_InventoryNode.inventory=inv
	var apple:=load("res://resource/eb/item/apple.tres").duplicate(true)
	apple.stack=5
	inv.add_item(apple)
	var apple2=load("res://resource/eb/item/apple.tres").duplicate(true)
	inv.add_item(apple2)
	var coco=load("res://resource/eb/item/folder.tres")
	inv.add_item(coco)
	var gun=load("res://resource/eb/item/gun.tres")
	inv.add_item(gun)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
