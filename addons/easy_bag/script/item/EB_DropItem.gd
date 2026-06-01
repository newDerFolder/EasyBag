@icon("res://addons/easy_bag/asset/icon/DropItem.png")
class_name EB_DropItem extends EB_BaseItem

@export var drop_weight:int=1
@export var item:EB_InventoryItemOverride

func create_instance()->EB_InventoryItem:
	return item.create_instance()
