class_name EB_InventoryItem extends EB_BaseItem

@export var item_name:String="new InventoryItem"
@export var attribute_arr:Array[EB_BaseAttribute]
@export var tag_arr:Array[EB_BaseTag]


func clone_self()->EB_InventoryItem:
	return self.duplicate(true)

func clone_with_id(item_id: String="") -> EB_InventoryItem:
	var ins:=self.duplicate(true)
	if item_id!="":
		ins.item_name=item_id
	return ins

func get_attribute_by_name(target_name:String)->EB_BaseAttribute:
	for i in attribute_arr:
		if i.attribute_name==target_name:
			return i
	push_error("EB_InventoryItem的get_attribute_by_name未找到该名称的物品")
	return

func get_attribute_value_by_name(target_name:String):
	var attribute=get_attribute_by_name(target_name)
	return attribute.get_value()

func has_tag_by_name(target_name:String)->bool:
	for i in tag_arr:
		if i.tag_name==target_name:
			return true
	return false
