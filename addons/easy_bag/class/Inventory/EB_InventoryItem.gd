extends Resource
class_name EB_InventoryItem

var from_codex:EB_Codex
@export var codex_item_id:String
@export var attribute_arr:Array[EB_ItemBaseAttribute]

func get_item_name()->String:
	return from_codex.item_dict[codex_item_id].item_name
func get_item_description()->String:
	return from_codex.item_dict[codex_item_id].item_description
func get_item_icon_path()->String:
	return from_codex.item_dict[codex_item_id].item_icon_path

##太高深了，后面再搞
#func get_attribute(item_attribute_index:int)->EB_ItemBaseAttribute:
	#return attribute_arr[item_attribute_index]
#
#func get_attribute_value(item_attribute_index:int):
	#return get_attribute(item_attribute_index).get_value(from_codex,codex_item_id,item_attribute_index)
	#
