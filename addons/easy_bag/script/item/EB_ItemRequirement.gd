class_name EB_ItemRequirement extends EB_BaseItem



enum CompareType {
	EQUAL,          
	GREATER_EQUAL,  
	LESS           
}
@export var require_item:EB_InventoryItem
@export var compare_type: CompareType = CompareType.GREATER_EQUAL
@export var require_attribute_arr:Array[EB_BaseAttribute]=[]

func consume_requirement(item: EB_InventoryItem):
	if not check_requirement(item):
		return false
	
	if compare_type == CompareType.GREATER_EQUAL:
		for i in require_attribute_arr:
			var attr = item.get_attribute_by_name(i.attribute_name)
			attr.set_value(attr.get_value() - i.get_value())
	
	return true

func compare(a1:EB_BaseAttribute,a2:EB_BaseAttribute)->bool:
	match compare_type:
		CompareType.EQUAL:
			return a1.compare_value(a2.get_value())
		CompareType.GREATER_EQUAL:
			if a1.get_value()>=a2.get_value():
				return true
			else:
				return false
		CompareType.LESS:
			if a1.get_value()<a2.get_value():
				return true
			else:
				return false
	return false

func check_requirement(item:EB_InventoryItem):
	for i in require_attribute_arr:
		if not item.has_attribute_by_name(i.attribute_name):
			return false
		if not compare(item.get_attribute_by_name(i.attribute_name),i):
			return false
	return true
