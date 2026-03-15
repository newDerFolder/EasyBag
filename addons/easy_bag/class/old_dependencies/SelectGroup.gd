extends RefCounted
class_name SelectGroup

# 选择模式枚举
enum Select_Mode {
	SINGLE,      # 单选
	MULTIPLE,    # 多选（Ctrl + 点击添加/移除）
}

var selected_nodes = []  # 存储所有当前选中的节点
var select_mode = Select_Mode.SINGLE  # 默认多选模式
var last_selected_node = null  # 用于连续选择（Shift）记录上一个点击的节点

func clean():
	selected_nodes.clear()



# 选择一个节点（根据模式决定行为）
func select(new_node, with_ctrl = false, with_shift = false):
	if not is_instance_valid(new_node): return

	# 逻辑优化：
	if with_ctrl and select_mode == Select_Mode.MULTIPLE:
		if new_node in selected_nodes:
			_remove_from_selection(new_node)
		else:
			_add_to_selection(new_node)
	elif with_shift and select_mode == Select_Mode.MULTIPLE:
		_select_range(last_selected_node, new_node)
	else:
		# 单选或普通点击：先清空，再添加
		_clear_selection()
		_add_to_selection(new_node)
	
	last_selected_node = new_node


# 添加节点到选中列表
func _add_to_selection(node):
	if node in selected_nodes:
		return
	selected_nodes.append(node)
	if node.has_method("change_select"):
		node.change_select(true)


# 从选中列表移除
func _remove_from_selection(node):
	if not (node in selected_nodes):
		return
	selected_nodes.erase(node)
	if node.has_method("change_select"):
		node.change_select(false)


# 清空所有选中
func _clear_selection():
	for node in selected_nodes:
		# 检查节点是否还没被销毁
		if is_instance_valid(node):
			if node.has_method("change_select"):
				node.change_select(false)
	selected_nodes.clear()


# 连续选择（例如从 A 到 B 的所有节点）
# 注意：这需要你知道节点之间的“顺序”，比如它们在同一个父容器中
func _select_range(from_node, to_node):
	var parent = from_node.get_parent()
	if parent != to_node.get_parent():
		return

	var children = parent.get_children()
	var from_idx = -1
	var to_idx = -1

	for i in range(children.size()):
		if children[i] == from_node:
			from_idx = i
		if children[i] == to_node:
			to_idx = i

	if from_idx == -1 or to_idx == -1:
		return

	var start = min(from_idx, to_idx)
	var end = max(from_idx, to_idx)

	_clear_selection()  # 连续选择通常会替换当前选择

	for i in range(start, end + 1):
		var child = children[i]
		if child.has_method("selectable") and child.selectable:  # 可选性检查（可选）
			_add_to_selection(child)


# 获取当前所有选中节点
func get_selected_nodes():
	return selected_nodes


# 取消所有选中
func deselect_all():
	_clear_selection()
	last_selected_node = null


# 设置选择模式
func set_mode(mode):
	if mode in [Select_Mode.SINGLE, Select_Mode.MULTIPLE]:
		select_mode = mode
