class_name EB_CapacityInventory extends EB_Inventory
#HACK:做容量库存中...（ai生成的请谨慎）
@export var max_size:int=100
@export var stack_attribute:EB_IntAttribute
@export var max_stack_attribute:EB_IntAttribute

func add_item(item:EB_InventoryItem):
	if get_inventory_size()<max_size:
		if stack_attribute==null or max_stack_attribute==null:
			super.add_item(item)
		else:
			_add_item_when_use_stack_rule(item)
	else:
		return null


func _add_item_when_use_stack_rule(new_item: EB_InventoryItem) -> EB_InventoryItem:
	if new_item == null:
		print("传入物品为null")
		return null

	var new_item_name = new_item.item_name
	
	var all_same_items: Array[EB_InventoryItem] = get_items_array_by_name(new_item_name)
	
	if all_same_items.is_empty():
		super.add_item(new_item)
		return new_item
	for existing_item in all_same_items:
		if not existing_item.has_attribute_by_name(stack_attribute.attribute_name):
			continue
		var current_stack = existing_item.get_attribute_value_by_name(stack_attribute.attribute_name)
		var max_stack_value = existing_item.get_attribute_value_by_name(max_stack_attribute.attribute_name)
		
		var space_left = max_stack_value - current_stack
		
		if space_left > 0:
			existing_item.set_attribute_value_by_name(stack_attribute.attribute_name, current_stack + 1)
			return existing_item 
	
	# 4. 如果遍历完所有同名物品，发现它们都已经堆叠到上限了（space_left <= 0）
	# 那么只能把这个新物品作为一个全新的堆叠，放入背包的新格子里
	return super.add_item(new_item)
