extends Resource
class_name EB_Codex

@export var linked_tag_set: EB_TagSet
@export var linked_attribute_set: EB_AttributeSet
@export var item_dict: Dictionary[String, EB_CodexItem]

# --- 原有方法 (已优化复用逻辑) ---

func get_instantiate_InventoryItem(item_config: EB_CodexConfigItem) -> EB_InventoryItem:
	if not item_dict.has(item_config.codex_id):
		push_error("EB_Codex: Item ID '%s' not found!" % item_config.codex_id)
		return null
	return _create_item_instance(item_config.codex_id)

# --- 新增方法 1: 通过物品名称获取 ---

func get_instantiate_InventoryItem_by_name(target_name: String) -> EB_InventoryItem:
	var found_id: String = ""
	
	# 遍历字典查找匹配的 item_name
	for codex_id in item_dict:
		var codex_item: EB_CodexItem = item_dict[codex_id]
		if codex_item and codex_item.item_name == target_name:
			found_id = codex_id
			break
	
	if found_id == "":
		push_error("EB_Codex: No item found with name '%s'" % target_name)
		return null
		
	return _create_item_instance(found_id)

# --- 新增方法 2: 通过物品 ID 获取 ---
# 假设 item_dict 的 Key (String) 就是物品 ID

func get_instantiate_InventoryItem_by_id(target_id: String) -> EB_InventoryItem:
	if not item_dict.has(target_id):
		push_error("EB_Codex: No item found with ID '%s'" % target_id)
		return null
		
	return _create_item_instance(target_id)

# --- 私有辅助方法：提取公共实例化逻辑 ---
# 避免代码重复，统一处理属性复制和初始化

func _create_item_instance(codex_id: String) -> EB_InventoryItem:
	var new_InventoryItem: EB_InventoryItem = EB_InventoryItem.new()
	var source_item: EB_CodexItem = item_dict[codex_id]
	
	# 设置基础引用信息
	new_InventoryItem.from_codex = self
	new_InventoryItem.codex_item_id = codex_id
	
	# 核心修复：填充字典而不是数组
	if source_item.attribute_dict:
		for key in source_item.attribute_dict:
			var base_attr: EB_ItemBaseAttribute = source_item.attribute_dict[key]
			if base_attr:
				# 使用 duplicate(true) 确保每个实例拥有独立的属性对象
				var attribute_instance: EB_ItemBaseAttribute = base_attr.duplicate(true)
				attribute_instance.is_instance_attribute = true
				
				# 存入 InventoryItem 的字典中
				new_InventoryItem.attribute_dict[key] = attribute_instance
	
	return new_InventoryItem
