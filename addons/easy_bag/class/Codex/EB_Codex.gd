extends Resource
class_name EB_Codex

@export var linked_tag_set:EB_TagSet
@export var linked_attribute_set:EB_AttributeSet
@export var item_dict:Dictionary[String,EB_CodexItem]


func get_instantiate_InventoryItem(item_config: EB_CodexConfigItem) -> EB_InventoryItem:
	var new_InventoryItem: EB_InventoryItem = EB_InventoryItem.new()
	
	for i in item_dict[item_config.codex_id].attribute_arr:
		var attribute=i.duplicate(true)
		attribute.is_instance_attribute=true
		new_InventoryItem.attribute_arr.append(attribute)
	new_InventoryItem.from_codex = self
	new_InventoryItem.codex_item_id=item_config.codex_id
	
	return new_InventoryItem
