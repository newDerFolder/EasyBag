class_name EB_RandomInt extends EB_BaseAttribute

@export var min_value:int
@export var max_value:int

func get_value()->int:
	return randi_range(min_value,max_value)

func set_value(new_value:Array[int]):
	if new_value.size()!=2:
		push_error("EB_RandomInt的set_value方法接收的列表size不为2")
		return
	self.min_value=new_value[0]
	self.max_value=new_value[1]
