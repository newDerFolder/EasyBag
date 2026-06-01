class_name EB_BoolAttribute extends EB_BaseAttribute

var value:bool=true

func set_value(new_value:bool):
	value=new_value
func get_value()->bool:
	return value
func compare_value(new_value:bool)->bool:
	if value==new_value:
		return true
	else:
		return false
