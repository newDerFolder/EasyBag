class_name EB_ArrayCodex extends EB_BaseCodex


@export var item_arr: Array[EB_InventoryItem] = []


var _name_to_index_cache: Dictionary[String, int] = {}


func get_InventoryItem_by_index(target_index: int) -> EB_InventoryItem:
	if target_index < 0 or target_index >= item_arr.size():
		push_error("EB_ArrayCodex: Index %d is out of bounds." % target_index)
		return null
	return item_arr[target_index].duplicate(true)


func get_InventoryItem_by_id(target_id: String) -> EB_InventoryItem:
	for item in item_arr:
		if item and item.id == target_id: 
			return item.duplicate(true)
			
	push_error("EB_ArrayCodex: No item found with ID '%s'" % target_id)
	return null


func get_InventoryItem_by_name(target_name: String) -> EB_InventoryItem:
	if _name_to_index_cache.has(target_name):
		var cached_index := _name_to_index_cache[target_name]
		if cached_index >= 0 and cached_index < item_arr.size():
			var item := item_arr[cached_index]
			if item and item.item_name == target_name:
				return item.duplicate(true)
			else:
				_name_to_index_cache.erase(target_name)

	for i in item_arr.size():
		var item := item_arr[i]
		if item and item.item_name == target_name:
			_name_to_index_cache[target_name] = i
			return item
			
	push_error("EB_ArrayCodex: No item found with name '%s'" % target_name)
	return null
