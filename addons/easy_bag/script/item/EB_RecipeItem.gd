## @experimental
class_name EB_RecipeItem extends EB_BaseItem


@export var input_item_arr: Array[EB_InventoryItem]
@export var output_item_arr: Array[EB_InventoryItem]
@export var auto_consume: bool = true


## 尝试按照配方合成物品
## @param items: 玩家当前持有的物品列表
## @return: 成功返回产出物副本列表，失败返回空数组
func craft(items: Array[EB_InventoryItem]) -> Array[EB_InventoryItem]:
	# --- 1. 预检：逐项核对材料 ---
	for required in input_item_arr:
		var need_amount: int = required.get_item_stack()
		var accumulated: int = 0
		
		# 在玩家背包里把所有同类物品的堆叠加起来看够不够
		for inv_item in items:
			if _is_same_item(inv_item, required):
				accumulated += inv_item.get_item_stack()
				if accumulated >= need_amount:
					break
		
		if accumulated < need_amount:
			push_warning("[EB_RecipeItem] 材料不足: %s 需要 %d / 拥有 %d" % [required.name, need_amount, accumulated])
			return []

	# --- 2. 实际扣减 ---
	if auto_consume:
		for required in input_item_arr:
			var need_amount: int = required.get_item_stack()
			
			for inv_item in items:
				if need_amount <= 0:
					break
				if _is_same_item(inv_item, required):
					var have: int = inv_item.get_item_stack()
					var deduct: int = min(need_amount, have)
					
					# 如果你暴露了 set_stack 或 stack 可写
					inv_item.set_item_stack(have - deduct)
					need_amount -= deduct

	# --- 3. 返回产出 ---
	var result: Array[EB_InventoryItem] = []
	for out_item in output_item_arr:
		var copy = out_item.duplicate()
		copy.set_item_stack(out_item.get_item_stack()) # 确保拿的是配方的原始数量
		result.append(copy)

	return result


## 私有：判定两个物品是否为同一种（按你项目的规则来）
func _is_same_item(a: EB_InventoryItem, b: EB_InventoryItem) -> bool:
	# 方案A：如果是 Resource 拖拽进来的实例比对
	# return a.resource_path == b.resource_path
	
	# 方案B：如果有 item_id
	# return a.item_id == b.item_id
	
	# 保守兜底写法：
	return a == b
