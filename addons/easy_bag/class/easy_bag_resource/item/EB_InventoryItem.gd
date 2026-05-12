extends EB_BaseItem
class_name EB_InventoryItem

var from_codex:EB_Codex
@export var codex_item_id:String
@export var attribute_dict:Dictionary[String,EB_ItemBaseAttribute]

func get_codex_item()->EB_CodexItem:
	if not from_codex.item_dict.has(codex_item_id):
		push_error("EB_InventoryItem:from_codex中没有该id的物品")
		return
	return from_codex.item_dict[codex_item_id]

func get_item_name()->String:
	return from_codex.item_dict[codex_item_id].item_name
func get_item_description()->String:
	return from_codex.item_dict[codex_item_id].item_description
func get_item_icon_path()->String:
	return from_codex.item_dict[codex_item_id].item_icon_path

func get_all_tag()->Array[EB_ItemTag]:
	var codex_item:=get_codex_item()
	return codex_item.get_all_item_tag()

func get_attribute(item_attribute_id:String)->EB_ItemBaseAttribute:
	item_attribute_id=str(item_attribute_id)
	if not attribute_dict.has(item_attribute_id):
		push_error("不存在的属性")
		return null
	attribute_dict[item_attribute_id].linked_attribute_set=from_codex.linked_attribute_set
	return attribute_dict[item_attribute_id]

func get_attribute_value(item_attribute_id:String):
	return get_attribute(item_attribute_id).get_value(from_codex,codex_item_id)
