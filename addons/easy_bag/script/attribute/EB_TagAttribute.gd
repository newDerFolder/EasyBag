## @experimental
class_name EB_TagAttribute extends EB_BaseAttribute


@export var value:EB_BaseTag=EB_BaseTag.new()

func get_value()->EB_BaseTag:
	return value
func set_value(new_value:EB_BaseTag):
	value=new_value
func compare_value(new_value:EB_BaseTag)->bool:
	if value.tag_name==new_value.tag_name:
		return true
	else:
		return false
