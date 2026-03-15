extends Resource
class_name EB_InventoryItem

var from_codex:EB_Codex
@export var codex_item_id:String
@export var attribute_dict:Dictionary[String,EB_ItemBaseAttribute]

func get_item_name()->String:
	return from_codex.item_dict[codex_item_id].item_name
func get_item_description()->String:
	return from_codex.item_dict[codex_item_id].item_description
func get_item_icon_path()->String:
	return from_codex.item_dict[codex_item_id].item_icon_path


func get_attribute(item_attribute_id:String)->EB_ItemBaseAttribute:
	item_attribute_id=str(item_attribute_id)
	if not attribute_dict.has(item_attribute_id):
		push_error("不存在的属性")
		return null
	attribute_dict[item_attribute_id].linked_attribute_set=from_codex.linked_attribute_set
	return attribute_dict[item_attribute_id]

func get_attribute_value(item_attribute_id:String):
	return get_attribute(item_attribute_id).get_value(from_codex,codex_item_id)
	
