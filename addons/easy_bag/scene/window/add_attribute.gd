extends ConfirmationDialog
class_name EB_CodexAddAttributeWindow

var attribute_set:EB_AttributeSet
@onready var attributes_list:GridContainer=$VBoxContainer/ScrollContainer/GridContainer
var items_select_group:SelectGroup=SelectGroup.new()
var codex_editor:EB_CodexEditor
var editor:EB_AttributeSetEditor=EB_AttributeSetEditor.new()
var codex_item_res:EB_CodexItem
var codex:EB_Codex

func _ready() -> void:
	editor.res=attribute_set
	items_select_group.select_mode=items_select_group.Select_Mode.MULTIPLE
	reload()

func reload():
	for i in attributes_list.get_children():
		i.queue_free()
	for i in attribute_set.attribute_dict:
		add_new_item_node(attribute_set.attribute_dict[i])

func add_new_item_node(link_item:EB_BaseAttribute):
	var new_item_node=preload("res://addons/easy_bag/scene/control/EB_AttributeSetItemNode.tscn").instantiate()
	new_item_node.res=link_item
	new_item_node.select_item_button_pressed.connect(_item_selected)
	attributes_list.add_child(new_item_node)

# 修改函数签名以匹配新信号
func _item_selected(item_res: EB_BaseAttribute, node: Control, event: InputEvent):
	var is_ctrl = event.ctrl_pressed
	var is_shift = event.shift_pressed
	
	# 现在 SelectGroup 知道你是 Ctrl+点击 还是 普通点击了
	items_select_group.select(node, is_ctrl, is_shift)


func _on_canceled() -> void:
	queue_free()


func _on_confirmed() -> void:
	# 1. 临时存储选中的资源（基类数组没问题）
	var new_add_attribute_res_arr: Array[EB_BaseAttribute] = []
	for i in items_select_group.selected_nodes:
		new_add_attribute_res_arr.append(i.res)
	
	# 2. 关键修改：声明为函数要求的具体子类数组类型
	# 注意：这里必须确保 get_item_ins 返回的对象确实是 EB_ItemBaseAttribute 类型
	var new_item_attribute_res_arr: Array[EB_ItemBaseAttribute] = []
	
	for i in new_add_attribute_res_arr:
		var item_ins = editor.get_instantiate_item_attribute(i,codex)
		# 强制转换并添加，确保类型安全
		if item_ins is EB_ItemBaseAttribute:
			new_item_attribute_res_arr.append(item_ins as EB_ItemBaseAttribute)
		else:
			push_error("返回的对象不是 EB_ItemBaseAttribute 类型！")
	
	# 3. 现在类型完全匹配了
	codex_editor.add_new_attribute_items(codex_item_res, new_item_attribute_res_arr)
