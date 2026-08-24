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
	
	
	
	
	$PanelContainer/EB_InventoryNode.refresh()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	var drop_pool:=preload("res://resource/eb/drop/dropPool.tres")
	var drop_item=drop_pool.get_drop()
	inv.add_item(drop_item)
	$PanelContainer/EB_InventoryNode.refresh()
