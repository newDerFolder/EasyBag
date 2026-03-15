extends Resource
class_name EB_ItemBaseAttribute

@export var attribute_id:String
@export var is_static_attribute=true
@export var is_instance_attribute=false
@export var linked_attribute_set:EB_AttributeSet



func get_set_attribute(attribute_set:EB_AttributeSet)->EB_BaseAttribute:
	return attribute_set.attribute_dict[attribute_id]

func get_value(codex:EB_Codex,codex_item_id:String,attribute_item_index:int):
	if is_static_attribute:
		return null
	else:
		return null
