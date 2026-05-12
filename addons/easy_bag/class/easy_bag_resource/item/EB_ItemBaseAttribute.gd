extends EB_BaseItem
class_name EB_ItemBaseAttribute

@export var attribute_id:String
@export var is_static_attribute=true
@export var is_instance_attribute=false
@export var linked_attribute_set:EB_AttributeSet



func get_set_attribute(attribute_set:EB_AttributeSet)->EB_BaseAttribute:
	return attribute_set.attribute_dict[attribute_id]

func get_value(codex:EB_Codex,codex_item_id:String):
	if not is_instance_attribute:
		return _get_self_value()
	elif is_static_attribute:
		return _get_codex_item_attribute_value(codex,codex_item_id)
	else:
		return _get_self_value()

func _get_self_value():
	push_error("请勿直接使用EB_ItemBaseAttribute的get_value方法")
func _get_codex_item_attribute_value(codex:EB_Codex,codex_item_id:String):
	#codex.item_dict[codex_item_id].attribute_dict[attribute_id]
	#子类的写法类似上面一行
	push_error("请勿直接使用EB_ItemBaseAttribute的get_value方法")
