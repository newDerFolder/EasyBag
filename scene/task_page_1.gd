extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var inv=EB_Inventory.new()
	$EB_InventoryNode.inventory=inv
	var apple=load("res://resource/eb/item/apple.tres")
	inv.add_item(apple)
	var apple2=load("res://resource/eb/item/apple.tres")
	inv.add_item(apple2)
	var coco=load("res://resource/eb/item/coco.tres")
	inv.add_item(coco)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
