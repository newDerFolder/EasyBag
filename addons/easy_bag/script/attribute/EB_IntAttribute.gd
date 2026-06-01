extends EB_BaseAttribute
class_name EB_IntAttribute

@export var value:int=0


func get_value()->int:
	return value
func set_value(new_value:int):
	value=new_value
func compare_value(new_value:int)->bool:
	if value==new_value:
		return true
	else:
		return false
