extends EB_BaseEditorUi
class_name EB_TagSetEditorUi 

#TODO:做标签编辑器界面中

@onready var item_VBC:=$HSplitContainer/item/ScrollContainer/VBoxContainer
@onready var icon_TextureRect:=$HSplitContainer/edit/ScrollContainer/VBoxContainer/HBoxContainer2/TextureRect
@onready var icon_FileLineEdit:=$HSplitContainer/edit/ScrollContainer/VBoxContainer/HBoxContainer2/FileLineEdit
@onready var name_lineEdit:=$HSplitContainer/edit/ScrollContainer/VBoxContainer/HBoxContainer/NameLineEdit
@onready var keyid_label:=$HSplitContainer/edit/ScrollContainer/VBoxContainer/HBoxContainer/KeyIDLabel
@onready var edit_VBC:=$HSplitContainer/edit/ScrollContainer/VBoxContainer
@onready var des_te:=$HSplitContainer/edit/ScrollContainer/VBoxContainer/TextEdit

var type_res:EB_TagSet
var type_editor:EB_TagSetEditor

var items_select_group:SelectGroup=SelectGroup.new()
var editing_tag_res:EB_Tag

func _ready() -> void:
	if not res is EB_TagSet:
		push_error("Tag编辑器接受了错误的文件类型")
	res as EB_TagSet
	editor=EB_TagSetEditor.new()
	type_editor=editor
	type_res=res
	editor.res=type_res


func reload():
	_reload_items()
	change()


func _reload_items():
	for i in item_VBC.get_children():
		i.queue_free()
	for i in type_res.tag_dict:
		var tag:EB_Tag=type_res.tag_dict[i]
		if tag.extends_tag_id=="":
			add_new_item_node(tag)

func add_new_item_node(tag:EB_Tag):
	var tag_node:EB_TagItemNode=preload("res://addons/easy_bag/scene/control/EbTagSetItemNode.tscn").instantiate()
	tag_node.res=tag
	tag_node.select_item_button_pressed.connect(_item_selected)
	item_VBC.add_child(tag_node)

func _item_selected(item_res: EB_Tag, node: Control, event: InputEvent):
	editing_tag_res = item_res

	items_select_group.select(node, event.ctrl_pressed, event.shift_pressed)
	
	_reload_edit_view(item_res)
	_change_item_node()

func _reload_edit_view(item_res:EB_Tag):
	if item_res==null:
		push_error("item_res:EB_Tag为null")
		return
	name_lineEdit.text=item_res.tag_name
	keyid_label.text=type_res.tag_dict.find_key(item_res)
	if item_res.item_icon_path!=null and FileAccess.file_exists(item_res.item_icon_path):
		icon_TextureRect.texture=load(item_res.item_icon_path)
		icon_FileLineEdit.file_path=item_res.item_icon_path
	else:
		icon_TextureRect.texture=null
		icon_FileLineEdit.file_path=""
	change()

func change():
	if editing_tag_res==null:
		edit_VBC.visible=false
	else:
		edit_VBC.visible=true
	_change_item_node()

func _change_item_node():
	for i in item_VBC.get_children():
		i.change()


func _on_save_button_pressed() -> void:
	save_file()

func save_file():
	type_editor.save_to_file(file_path)
	context.should_reload_on_return=true

func _on_add_root_tag_button_pressed() -> void:
	type_editor.add_new_item()
	reload()


func _on_name_line_edit_text_changed(new_text: String) -> void:
	editing_tag_res.tag_name=new_text
	_change_item_node()


func _on_file_line_edit_file_path_changed(new_path: String) -> void:
	editing_tag_res.item_icon_path=new_path
	_change_item_node()
	_reload_edit_view(editing_tag_res)


func _on_close_button_pressed() -> void:
	close_file()

func close_file():
	save_file()
	queue_free()


func _on_text_edit_text_changed() -> void:
	editing_tag_res.tag_description=des_te.text
	_change_item_node()
