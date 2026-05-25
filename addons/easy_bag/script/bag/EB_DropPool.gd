@icon("res://addons/easy_bag/asset/icon/DropPool.png")
class_name EB_DropPool extends EB_BaseCodex

@export var drop_items: Array[EB_DropItem] = []

# 根据权重随机获取一个掉落的物品实例
func get_drop() -> EB_InventoryItem:
	if drop_items.is_empty():
		push_warning("掉落池为空！请检查配置。")
		return null
	
	# 1. 计算总权重
	var total_weight := 0
	for drop_item in drop_items:
		if drop_item != null and drop_item.item != null: # 做好空值防护
			total_weight += drop_item.drop_weight
	
	if total_weight == 0:
		push_warning("掉落池总权重为0，无法进行抽取！")
		return null
	
	# 2. 生成 [0, total_weight) 之间的随机数
	var random_value := randi() % total_weight
	
	# 3. 轮盘赌算法：通过累加权重来定位命中的物品
	var current_weight := 0
	for drop_item in drop_items:
		if drop_item == null or drop_item.item == null:
			continue
			
		current_weight += drop_item.drop_weight
		if random_value < current_weight:
			# 命中该物品，调用之前建议的 generate_drop 方法生成实际实例
			return drop_item.create_instance()
	
	# 理论上不会走到这一步（防浮点误差或极端边界情况兜底）
	return null
