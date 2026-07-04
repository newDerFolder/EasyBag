extends EB_BaseCodex
class_name EB_DictionaryCodex


@export var item_dict: Dictionary[String,EB_InventoryItem]
@export var use_id_as_item_name=true

var _name_to_id_cache: Dictionary[String, String] = {}

func get_InventoryItem_by_id(target_id:String="") -> EB_InventoryItem:
	if not item_dict.has(target_id):
		push_error("EB_Codex: No item found with ID '%s'" % target_id)
		return null
	else:
		if use_id_as_item_name:
			return item_dict[target_id].clone_with_id(target_id)
		else:
			return item_dict[target_id].clone_self()

func get_InventoryItem_by_name(target_name: String) -> EB_InventoryItem:
	if _name_to_id_cache.has(target_name):
		var cached_id := _name_to_id_cache[target_name]
		if item_dict.has(cached_id):
			return item_dict[cached_id].duplicate(true)
		else:
			_name_to_id_cache.erase(target_name)
	for codex_id in item_dict:
		var item: EB_InventoryItem = item_dict[codex_id]
		if item and item.item_name == target_name:
			_name_to_id_cache[target_name] = codex_id
			return item.duplicate(true)
			
	push_error("EB_Codex: No item found with name '%s'" % target_name)
	return null
