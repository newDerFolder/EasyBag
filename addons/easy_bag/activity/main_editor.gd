extends Control
class_name EB_MainEditorUi
@onready var tab_container:TabContainer=$VBoxContainer/TabContainer
@onready var label_editing_path:Label=$VBoxContainer/MenuBar/HFlowContainer/PanelContainer/LabelEditingPath
@onready var file_menu:MenuButton=$VBoxContainer/MenuBar/HFlowContainer/MenuFile

@onready var label_attribute:Label=$VBoxContainer/MenuBar/HFlowContainer/LabelAttributeSet
@onready var linked_AttributeSet_Btn:Button=$VBoxContainer/MenuBar/HFlowContainer/LinkedAttributeButton
@onready var label_tagSet:Label=$VBoxContainer/MenuBar/HFlowContainer/LabelTagSet
@onready var linked_TagSet_Btn:Button=$VBoxContainer/MenuBar/HFlowContainer/LinkedTagSetButton

@onready var file_dialog: FileDialog = FileDialog.new()

var file_popup_menu:PopupMenu

var context:EB_EditorNodeContext=EB_EditorNodeContext.new()

func _ready() -> void:
	file_popup_menu=file_menu.get_popup()
	file_popup_menu.id_pressed.connect(_file_popup_menu_id_pressed)
	if not has_node("FileDialog"):
		add_child(file_dialog)
	file_dialog.connect("file_selected", _on_attribute_file_selected)
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.add_filter("*.tres", "EB_AttributeSet Resource")
	change()

func change():
	change_linked_bar(get_now_editor_res())

func _file_popup_menu_id_pressed(id:int):
	match id:
		0:
			var CreateNewFile:ConfirmationDialog=preload("res://addons/easy_bag/scene/window/CreateNewFile.tscn").instantiate()
			CreateNewFile.scene_created.connect(_created_new_file)
			add_child(CreateNewFile)
		1:
			_open_file_item()
func _created_new_file(editor_scene):
	editor_scene.name=editor_scene.file_path.get_basename().get_file()
	tab_container.add_child(editor_scene)

func _open_file_item():
	var file_dialog=FileDialog.new()
	add_child(file_dialog)
	
	var target_dir = "res://addons/easy_bag/workfile/"
	if not DirAccess.dir_exists_absolute(target_dir):
		DirAccess.make_dir_recursive_absolute(target_dir)
	file_dialog.current_dir = target_dir
	
	file_dialog.add_filter("*.tres", "Godot Resource")
	file_dialog.file_mode=FileDialog.FILE_MODE_OPEN_FILE
	file_dialog.initial_position=Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.file_selected.connect(_open_file_dialog_file_selected)
	file_dialog.popup()

func _open_file_dialog_file_selected(path: String):
	var new_resource = ResourceLoader.load(path)
	if new_resource:
		# 核心：确保资源对象持有正确的路径
		new_resource.take_over_path(path) 
		
		if new_resource is EB_Codex:
			var new_editor = preload("res://addons/easy_bag/activity/CodexEditor.tscn").instantiate()
			new_editor.file_path = path # 这是你 UI 逻辑用的
			new_editor.res = new_resource
			new_editor.name=new_editor.file_path.get_basename().get_file()
			tab_container.add_child(new_editor)
			new_editor.reload()
		elif new_resource is EB_AttributeSet:
			var new_editor:EB_AttributeEditorUi=preload("res://addons/easy_bag/activity/AttributeEditor.tscn").instantiate()
			new_editor.file_path=path
			new_editor.res=new_resource
			new_editor.name=new_editor.file_path.get_basename().get_file()
			tab_container.add_child(new_editor)
			new_editor.reload()

#切换编辑的文件(编辑器)时
func _on_tab_container_tab_selected(tab: int) -> void:
	if tab_container.get_children().size()<=0:
		return
	context.change_editorNode(tab_container.get_child(tab))
	label_editing_path.text=context.now_editor_ui_node.file_path
	if context.should_reload_on_return:
		context.now_editor_ui_node=load(context.now_editor_ui_node.file_path).instantiate()
	if context.now_editor_ui_node is EB_CodexEditorUi:
		context.now_editor_ui_node.refresh_context()
	change_linked_bar(context.now_editor_ui_node.res)

func _on_tab_container_active_tab_rearranged(idx_to: int) -> void:
	change()

func change_linked_bar(res:Resource):
	if context.now_editor_ui_node==null or tab_container.get_children().size()<=0:
		set_linkedBar_attributeSet_visible(false)
		set_linkedBar_tagSet_visible(false)
	elif res is EB_Codex:
		set_linkedBar_attributeSet_visible(true)
		set_linkedBar_tagSet_visible(true)
	elif res is EB_AttributeSet:
		set_linkedBar_attributeSet_visible(false)
		set_linkedBar_tagSet_visible(true)

func get_now_editor_res()->Resource:
	if context.now_editor_ui_node==null or context.now_editor_ui_node.res==null:
		return null
	else:
		return context.now_editor_ui_node.res

func set_linkedBar_attributeSet_visible(set_visible: bool):
	label_attribute.visible = set_visible
	linked_AttributeSet_Btn.visible = set_visible
	if set_visible:
		var current_res = get_now_editor_res()
		if current_res == null or current_res.linked_attribute_set == null:
			linked_AttributeSet_Btn.text = "null"
			linked_AttributeSet_Btn.set_tooltip_text("")
		else:
			var path = current_res.linked_attribute_set.resource_path  # 推荐使用 resource_path
			
			var file_name = path.get_file()  # 获取文件名，如 "PlayerStats.tres"
			linked_AttributeSet_Btn.text = file_name
			linked_AttributeSet_Btn.set_tooltip_text(path)  # 完整路径作为提示
	else:
		# 如果隐藏，可选清除 tooltip
		linked_AttributeSet_Btn.set_tooltip_text("")
func set_linkedBar_tagSet_visible(set_visible:bool):
	label_tagSet.visible=set_visible
	linked_TagSet_Btn.visible=set_visible


func _on_linked_attribute_button_pressed() -> void:
	var default_dir = "res://addons/easy_bag/workfile/AttributeSet/"
	if DirAccess.dir_exists_absolute(default_dir):
		file_dialog.current_dir = default_dir
	# 只允许选择 EB_AttributeSet 类型的资源
	file_dialog.clear_filters()
	file_dialog.add_filter("*.tres", "AttributeSet Resource")
	file_dialog.popup()

# 当用户选择了文件后
func _on_attribute_file_selected(path: String) -> void:
	var res = ResourceLoader.load(path)
	if res == null: return
	
	var current_res = get_now_editor_res()
	if current_res == null: return

	# 设置关联
	current_res.linked_attribute_set = res
	
	# 获取编辑器中记录的可靠路径
	var save_path = context.now_editor_ui_node.file_path 
	
	if save_path == "" or save_path == null:
		# 如果编辑器里没存，尝试用资源自带的
		save_path = current_res.resource_path
	
	if save_path == "":
		push_error("无法保存：找不到有效的保存路径！")
		return

	# 保存到确定的路径
	var error = ResourceSaver.save(current_res, save_path)
	if error != OK:
		push_error("保存资源失败，错误代码: ", error)
	else:
		print("关联已更新并保存至: ", save_path)
	
	context.now_editor_ui_node.reload() 
	linked_AttributeSet_Btn.text = path.get_file()
