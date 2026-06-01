class_name EB_InventoryItemOverride extends EB_BaseItem

@export var item:EB_InventoryItem
@export var override_attribute_arr:Array[EB_BaseAttribute]

func create_instance()->EB_InventoryItem:
	var new_item=item.clone_self()
	for i in override_attribute_arr:
		if new_item.get_attribute_by_name(i.attribute_name):
			new_item.get_attribute_by_name(i.attribute_name).set_value(i.get_value())
	return new_item
