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

# 处理带堆叠规则的私有方法
func _add_item_when_use_stack_rule(new_item: EB_InventoryItem) -> EB_InventoryItem:
	if new_item == null:
		print("传入物品为null")
		return null # 建议加上明确的返回值

	var new_item_name = new_item.item_name
	
	# 1. 获取背包中所有的同名物品数组
	var all_same_items: Array[EB_InventoryItem] = get_items_array_by_name(new_item_name)
	
	# 2. 如果背包里完全没有这个物品，直接调用父类添加新物品并占用一个新格子
	if all_same_items.is_empty():
		super.add_item(new_item)
		return new_item
	
	# 3. 遍历所有同名物品，寻找还有剩余空间的堆叠
	for existing_item in all_same_items:
		# 确保该物品拥有我们定义的堆叠属性
		if not existing_item.has_attribute_by_name(stack_attribute.attribute_name):
			continue
			
		var current_stack = existing_item.get_attribute_value_by_name(stack_attribute.attribute_name)
		var max_stack_value = existing_item.get_attribute_value_by_name(max_stack_attribute.attribute_name)
		
		# 计算还能塞进去多少个
		var space_left = max_stack_value - current_stack
		
		if space_left > 0:
			# 找到有空位的堆叠，将数量 +1
			existing_item.set_attribute_value_by_name(stack_attribute.attribute_name, current_stack + 1)
				
			#print("物品堆叠成功！当前数量:", current_stack + 1)
			return existing_item 
	
	# 4. 如果遍历完所有同名物品，发现它们都已经堆叠到上限了（space_left <= 0）
	# 那么只能把这个新物品作为一个全新的堆叠，放入背包的新格子里
	return super.add_item(new_item)
