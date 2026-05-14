## @deprecated
extends EB_ItemBaseAttribute
class_name EB_ItemIntAttribute

@export var value:int=0



#func get_value(codex:EB_Codex,codex_item_id:String,attribute_item_index:int):
	#if not is_instance_attribute:
		#return value
	#elif is_static_attribute:
		#var codex_attribute=codex.item_dict[codex_item_id].attribute_arr[attribute_item_index]
		#if codex_attribute.is_instance_attribute==false:
			#return codex_attribute.get_value(codex,codex_item_id,attribute_item_index)
	#else:
		#return value

func _get_self_value():
	return value
func _get_codex_item_attribute_value(codex:EB_Codex,codex_item_id:String):
	return codex.item_dict[codex_item_id].attribute_dict[attribute_id].value
