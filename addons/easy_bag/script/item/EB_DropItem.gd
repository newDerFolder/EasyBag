@icon("res://addons/easy_bag/asset/icon/DropItem.png")
class_name EB_DropItem extends EB_BaseItem

@export var drop_weight:int=1
@export var item:EB_InventoryItem
@export var attribute_arr:Array[EB_BaseAttribute]

func create_instance()->EB_InventoryItem:
	var drop_item=item.clone_self()
	for i in attribute_arr:
		if drop_item.get_attribute_by_name(i.attribute_name):
			drop_item.get_attribute_by_name(i.attribute_name).set_value(i.get_value())
	return drop_item
