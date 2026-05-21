extends EasyBagResource
class_name EB_Inventory


@export var item_array:Array[EB_InventoryItem]

func has_item_by_name(target_name:String)->bool:
	if get_item_by_name(target_name)==null:
		return false
	else:
		return true

func get_item_by_name(target_name:String)->EB_InventoryItem:
	for i in item_array:
		if i.item_name==target_name:
			return i
	return null

func get_all_items()->Array[EB_InventoryItem]:
	return item_array
