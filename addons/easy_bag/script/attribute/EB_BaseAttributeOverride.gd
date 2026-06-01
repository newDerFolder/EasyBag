class_name EB_BaseAttributeOverride extends EB_BaseAttribute

@export var attribute:EB_BaseAttribute

#TODO:做重新属性数值类中...

func get_value():
	return attribute.get_value()
func set_value(new_value):
	attribute.set_value(new_value)
func compare_value(new_value)->bool:
	return attribute.compare_value(new_value)
func get_attribute_name()->String:
	return attribute.get_attribute_name()
