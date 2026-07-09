class_name EB_RecipeItem extends EB_BaseItem


@export var input_item_arr: Array[EB_ItemRequirement]
@export var output_item_arr: Array[EB_InventoryItemOverride]
@export var auto_consume: bool = true


func craft(items: Array[EB_InventoryItem]) -> Array[EB_InventoryItem]:
	# 1. 检查所有材料需求是否满足
	for i in input_item_arr:
		var found := false
		for a in items:
			if a.item_name == i.require_item.item_name:
				found = true
				if not i.check_requirement(a):
					return []
		if not found:
			return []

	# 2. 根据 auto_consume 决定是否扣除材料
	if auto_consume:
		for i in input_item_arr:
			for a in items:
				if a.item_name == i.require_item.item_name:
					i.consume_requirement(a)
					break

	# 3. 生成产物
	var out_items: Array[EB_InventoryItem] = []
	for i in output_item_arr:
		out_items.append(i.create_instance())
	return out_items
