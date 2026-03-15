extends Resource
class_name EB_Inventory

var linked_codex:EB_Codex
@export var item_array:Array[EB_InventoryItem]


func add_item(new_item:EB_InventoryItem)->void:
	item_array.append(new_item)

func has_item(item_config:EB_CodexConfigItem)->bool:
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			return true
	return false
	
func get_item(item_config:EB_CodexConfigItem)->EB_InventoryItem:
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			i.from_codex=linked_codex
			return i
	return null

func get_items(item_config:EB_CodexConfigItem)->Array[EB_InventoryItem]:
	var items_arr:Array[EB_InventoryItem]=[]
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			i.from_codex=linked_codex
			item_array.append(i)
	return items_arr
