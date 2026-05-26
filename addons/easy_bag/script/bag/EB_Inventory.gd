extends EB_BaseInventory
class_name EB_Inventory


@export var item_array:Array[EB_InventoryItem]


func get_inventory_size():
	return item_array.size()

func add_item(item:EB_InventoryItem):
	item_array.append(item)

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

func get_items_array_by_name(target_name:String)->Array[EB_InventoryItem]:
	var arr:Array[EB_InventoryItem]=[]
	for i in item_array:
		if i.item_name==target_name:
			arr.append(i)
	return arr

func take_item_by_name(target_name:String)->EB_InventoryItem:
	var item=get_item_by_name(target_name)
	if item==null:
		return null
	else:
		return take_item(item)

func take_item(item: EB_InventoryItem)->EB_InventoryItem:
	if item_array.has(item):
		item_array.erase(item)
		return item
	return null


func get_all_items()->Array[EB_InventoryItem]:
	return item_array
