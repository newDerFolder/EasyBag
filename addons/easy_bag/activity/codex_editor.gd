extends EB_BaseEditorUi
class_name EB_CodexEditorUi

@onready var items_list=$VBoxContainer/HSplitContainer/Items/ScrollContainer/HFlowContainer
@onready var name_label:LineEdit=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/NameLabel
@onready var rename_button:Button=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/RenameButton
@onready var keyid_label:Label=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/KeyIdLabel
@onready var rename_keyid_button:Button=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/RenameKeyButton
@onready var icon_texture_rect:TextureRect=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer/IconTextureRect
@onready var icon_fileLineEdit:FileLineEdit=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer/IconFileLineEdit
@onready var edit_item_scrollContainer:ScrollContainer=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer
@onready var description_TextEdit:TextEdit=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/info/VBoxContainer/DescriptionTextEdit
@onready var attributes_list:VBoxContainer=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/attribute/VBoxContainer/VBoxContainer
@onready var tags_list:VBoxContainer=$VBoxContainer/HSplitContainer/EditItem/ScrollContainer/VBoxContainer/tag/VBoxContainer/VBC


var items_select_group:SelectGroup=SelectGroup.new()
var editing_codex_item_res:EB_CodexItem=null

func _ready() -> void:
	editor=EB_CodexEditor.new()
	editor.res=res
	editor.attribute_set=res.linked_attribute_set

func change():
	_change_edit_view()
	_change_item_nodes()
func reload():
	res=load(file_path)
	items_select_group.clean()
	_reload_items_list()
	change()

func _on_button_close_pressed() -> void:
	close_file()
	pass # Replace with function body.

func _on_button_save_pressed() -> void:
	print("save now")
	save_file()
	pass # Replace with function body.

func save_file():
	if file_path != "" and res != null:
		# 1. 保存并获取新实例
		var new_res = editor.save_to_file(file_path)
		editor.save_config_to_file(file_path)
		
		# 2. 记录当前正在编辑的物品 ID
		var current_id = ""
		if editing_codex_item_res:
			current_id = res.item_dict.find_key(editing_codex_item_res)
		
		# 3. 更新 UI 持有的资源引用
		res = new_res
		editor.res = res
		
		# 4. 关键：同步当前选中的物品引用到新资源中的对象
		if current_id != "" and res.item_dict.has(current_id):
			editing_codex_item_res = res.item_dict[current_id]
		
		# 5. 刷新列表，否则列表里的 Node 还连着旧资源
		_reload_items_list()
func close_file():
	save_file()
	queue_free()


#region ItemsView


func _change_item_nodes():
	for i in items_list.get_children():
		i.change()

func _on_button_add_new_item_pressed() -> void:
	var new_item_id = editor.add_new_item()
	# 只有在 ID 有效且字典里确实存在该项时才操作 UI
	if new_item_id != null and res.item_dict.has(new_item_id):
		var link_item = res.item_dict.get(new_item_id)
		add_new_codex_item_node(link_item)

func _reload_items_list():
	for i in items_list.get_children():
		i.queue_free()
	for i in res.item_dict:
		add_new_codex_item_node(res.item_dict[i])

func add_new_codex_item_node(link_item:EB_CodexItem):
	var new_item_node=preload("res://addons/easy_bag/scene/control/EB_CodexItemNode.tscn").instantiate()
	new_item_node.linked_item_res=link_item
	new_item_node.select_item_button_pressed.connect(_item_selected)
	items_list.add_child(new_item_node)
#endregion


#region EditView





func _change_edit_view():
	if editing_codex_item_res==null:
		edit_item_scrollContainer.visible=false
		return
	else:
		edit_item_scrollContainer.visible=true


func _reload_edit_view(codex_item_res: EB_CodexItem):
	if codex_item_res == null: return
	
	var item_key = res.item_dict.find_key(codex_item_res)
	# 如果找不到 Key（比如 Nil），给个默认值或报错
	keyid_label.text = str(item_key) if item_key != null else "Unknown"
	
	name_label.text = codex_item_res.item_name
	description_TextEdit.text=codex_item_res.item_description
	if codex_item_res.item_icon_path!=null and FileAccess.file_exists(codex_item_res.item_icon_path):
		icon_texture_rect.texture=load(codex_item_res.item_icon_path)
		icon_fileLineEdit.file_path=codex_item_res.item_icon_path
	else:
		icon_texture_rect.texture=null
		icon_fileLineEdit.file_path=""
	_reload_attribute_value_editor(codex_item_res)
	_reload_tags(codex_item_res)
func _reload_tags(item_res:EB_CodexItem):
	for i in tags_list.get_children():
		i.queue_free()
	for i in item_res.get_all_item_tag():
		add_tag_editor(i,res.linked_tag_set)

func add_tag_editor(item_res:EB_ItemTag,set_res:EB_TagSet):
	if set_res == null:
		push_error("CodexEditorUi:add_tag_editor传入的set_res为null")
		return
	var new_tag=preload("res://addons/easy_bag/scene/item_view/codex/tag/CodexItemTagItemNode.tscn").instantiate()
	new_tag.res=item_res
	new_tag.set_res=set_res
	tags_list.add_child(new_tag)
func _reload_attribute_value_editor(item_res:EB_CodexItem):
	for i in attributes_list.get_children():
		i.queue_free()
	#for i in item_res.attribute_arr:
		#add_attribute_value_editor(i)
	for i in item_res.attribute_dict:
		add_attribute_value_editor(item_res.attribute_dict[i])
func add_attribute_value_editor(item_res:EB_ItemBaseAttribute):
	var new_editor:EB_CodexBaseAttributeValueEditorUi
	if item_res is EB_ItemIntAttribute:
		new_editor=preload("res://addons/easy_bag/scene/attributeValueEditor/ItemValue/IntAttributeItemEditor.tscn").instantiate()
	elif item_res is EB_ItemBaseAttribute:
		new_editor=preload("res://addons/easy_bag/scene/attributeValueEditor/ItemValue/BaseAttributeItemEditor.tscn").instantiate()
	else:
		return
	new_editor.del_item_attribute.connect(_on_item_attribute_del)
	new_editor.res=item_res
	new_editor.set_res=res.linked_attribute_set
	attributes_list.add_child(new_editor)
func _on_item_attribute_del(item_attribute_res:EB_ItemBaseAttribute):
	editor.del_item_attribute(editing_codex_item_res,item_attribute_res)
	#if editing_codex_item_res.attribute_arr.has(item_attribute_res):
		#editing_codex_item_res.attribute_arr.erase(item_attribute_res)
	refresh_context()

##信号方法
func _item_selected(codex_item_res:EB_CodexItem,node: Control):
	editing_codex_item_res=codex_item_res
	items_select_group.select(node)
	_reload_edit_view(codex_item_res)
	
	change()

func _on_name_label_editing_toggled(toggled_on: bool) -> void:
	editing_codex_item_res.item_name=name_label.text
	change()
	pass # Replace with function body.
func _on_icon_file_line_edit_file_path_changed(new_path: String) -> void:
	editing_codex_item_res.item_icon_path=new_path
	change()
	pass # Replace with function body.

func _on_description_text_edit_text_changed() -> void:
	editing_codex_item_res.item_description=description_TextEdit.text
	change()
	pass # Replace with function body.


#endregion


func _on_add_attribute_button_pressed() -> void:
	if editing_codex_item_res==null or res.linked_attribute_set==null:
		return
	var win:ConfirmationDialog=preload("res://addons/easy_bag/scene/window/AddAttribute.tscn").instantiate()
	win.attribute_set=res.linked_attribute_set
	win.codex_editor=editor
	win.codex_item_res=editing_codex_item_res
	#win.codex=res
	win.confirmed.connect(_on_add_attribute_win_closed)
	add_child(win)
func _on_add_attribute_win_closed():
	_reload_edit_view(editing_codex_item_res)
	refresh_context()

func refresh_context():
	if editing_codex_item_res:
		# 重新加载当前选中项的详情界面
		_reload_edit_view(editing_codex_item_res)
		_reload_attribute_value_editor(editing_codex_item_res)
		_reload_tags(editing_codex_item_res)
	
	# 如果你的顶部关联栏信息也可能变（比如 LinkedAttributeSet 变了），
	# 这里可以通知 MainEditor 刷新顶部条
	if get_parent() is TabContainer:
		var main_editor = get_tree().get_first_node_in_group("MainEditor") # 建议给主编辑器加个组
		if main_editor:
			main_editor.change_linked_bar(res)


func _on_add_tag_pressed() -> void:
	if editing_codex_item_res==null or res.linked_tag_set==null:
		return
	var new_win=EB_WindowFactory.create_add_tag_window_for_codex(self)
	add_child(new_win)
