extends EB_BaseInventory
class_name EB_Inventory


@export var item_array:Array[EB_InventoryItem]

signal inventory_change()


func had_item(item:EB_InventoryItem)->bool:
	if item_array.has(item):
		return true
	else:
		return false

func move_item_to_inventory(to_inventory:EB_BaseInventory,item:EB_InventoryItem)->bool:
	if to_inventory==null:
		return false
	if had_item(item):
		var done=to_inventory.receive_item_from_inventory(item)
		if done:
			take_item(item)
			return true
		else:
			return false
	else:
		return false

func receive_item_from_inventory(item:EB_InventoryItem) -> bool:
	if item==null:
		return false
	else:
		add_item(item)
		return true

func get_inventory_size()->int:
	return item_array.size()

func add_item(item:EB_InventoryItem)->bool:
	item_array.append(item)
	inventory_change.emit()
	return true

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
		inventory_change.emit()
		return item
	return null
	


func get_all_items()->Array[EB_InventoryItem]:
	return item_array
