extends EasyBagResource
class_name EB_Inventory

var linked_codex:EB_Codex
@export var item_array:Array[EB_InventoryItem]

func refresh_all_items_codex_link() -> void:
	if linked_codex == null:
		return
	for item in item_array:
		if item:
			item.from_codex = linked_codex

func link_codex(new_link_codex:EB_Codex):
	if(new_link_codex==null):
		push_error("连接到为null的Codex")
	else:
		linked_codex=new_link_codex
		refresh_all_items_codex_link()

func add_item(new_item:EB_InventoryItem)->void:
	item_array.append(new_item)
	if linked_codex != null:
		new_item.from_codex = linked_codex

func has_item(item_config:EB_CodexConfigItem)->bool:
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			return true
	return false

func get_all_items()->Array[EB_InventoryItem]:
	return item_array

func get_item(item_config:EB_CodexConfigItem)->EB_InventoryItem:
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			#i.from_codex=linked_codex
			return i
	return null

func get_items(item_config:EB_CodexConfigItem)->Array[EB_InventoryItem]:
	var items_arr:Array[EB_InventoryItem]=[]
	for i in item_array:
		if i.codex_item_id==item_config.codex_id:
			#i.from_codex=linked_codex
			items_arr.append(i)
	return items_arr
