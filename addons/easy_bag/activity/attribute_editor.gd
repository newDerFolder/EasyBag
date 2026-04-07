extends EB_BaseEditorUi
class_name EB_AttributeSetEditorUi



@onready var items_list:GridContainer=$HSplitContainer/HSplitContainer/item/ScrollContainer/GridContainer
@onready var name_lineEdit:LineEdit=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer/NameLineEdit
@onready var icon_TextureRect:TextureRect=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/IconTextureRect
@onready var icon_FileLineEdit:FileLineEdit=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer2/IconFileLineEdit
@onready var type_OptionButtoon:OptionButton=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer3/TypeOptionButton
@onready var keyid_label:Label=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/HBoxContainer/KeyIdLabel
@onready var description_TextEdit:TextEdit=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/info/VBoxContainer/DescriptionTextEdit
@onready var value_fold:FoldableContainer=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer/value
@onready var edit_VBC:=$HSplitContainer/HSplitContainer/edit/ScrollContainer/VBoxContainer

var items_select_group:SelectGroup=SelectGroup.new()
var editing_attribute_item_res:EB_BaseAttribute


var attribute_factories = {
	"EB_IntAttribute": preload("res://addons/easy_bag/class/easy_bag_resource/item/EB_IntAttribute.gd"),
	"EB_BaseAttribute": preload("res://addons/easy_bag/class/easy_bag_resource/item/EB_BaseAttribute.gd"),
	}



func _ready() -> void:
	if not res is EB_AttributeSet:
		push_error("属性编辑器接受了错误的文件类型")
	editor=EB_AttributeSetEditor.new()
	editor as EB_AttributeSetEditor
	editor.res=res

func save_file():
	#if file_path!=null and res!=null:
	editor.save_to_file(file_path)
	context.should_reload_on_return=true
func close_file():
	save_file()
	queue_free()

func change():
	if editing_attribute_item_res==null:
		edit_VBC.visible=false
	else:
		edit_VBC.visible=true
	_chnange_item_node()

func _chnange_item_node():
	for i in items_list.get_children():
		i.change()

func reload():
	_reload_items_list()
	change()

func _reload_edit_view(item_res:EB_BaseAttribute):
	if res==null:
		return
	keyid_label.text=res.attribute_dict.find_key(item_res)
	name_lineEdit.text=item_res.item_name
	description_TextEdit.text=item_res.item_description
	if item_res.item_icon_path!=null and FileAccess.file_exists(item_res.item_icon_path):
		icon_TextureRect.texture=load(item_res.item_icon_path)
		icon_FileLineEdit.file_path=item_res.item_icon_path
	else:
		icon_TextureRect.texture=null
		icon_FileLineEdit.file_path=""
	_reload_attribute_value_editor(item_res)
	_reload_type_opBtn(item_res)
	change()
func _reload_type_opBtn(item_res:EB_BaseAttribute):
	if item_res is EB_IntAttribute:
		type_OptionButtoon.selected=1
	else:
		type_OptionButtoon.selected=0

func _reload_attribute_value_editor(item_res:EB_BaseAttribute):
	for i in value_fold.get_children():
		i.queue_free()
	var new_editor
	if item_res is EB_IntAttribute:
		new_editor=preload("res://addons/easy_bag/scene/attributeValueEditor/SetValue/IntAttributeSetEditor.tscn").instantiate()
	else:
		return
	new_editor.res=item_res
	value_fold.add_child(new_editor)

func _reload_items_list():
	for i in items_list.get_children():
		i.queue_free()
	for i in res.attribute_dict:
		add_new_item_node(res.attribute_dict[i])

func add_new_item_node(link_item:EB_BaseAttribute):
	var new_item_node=preload("res://addons/easy_bag/scene/control/EB_AttributeSetItemNode.tscn").instantiate()
	new_item_node.res=link_item
	new_item_node.select_item_button_pressed.connect(_item_selected)
	items_list.add_child(new_item_node)


func _item_selected(item_res: EB_BaseAttribute, node: Control, event: InputEvent):
	editing_attribute_item_res = item_res

	items_select_group.select(node, event.ctrl_pressed, event.shift_pressed)
	
	_reload_edit_view(item_res)
	_chnange_item_node()

func _on_button_add_new_item_pressed() -> void:
	var new_item_id = editor.add_new_item()
	# 只有在 ID 有效且字典里确实存在该项时才操作 UI
	if new_item_id != null and res.attribute_dict.has(new_item_id):
		var link_item = res.attribute_dict.get(new_item_id)
		# 直接调用你写好的封装函数即可
		add_new_item_node(link_item)
	change()


func _on_button_close_pressed() -> void:
	close_file()


func _on_name_line_edit_editing_toggled(toggled_on: bool) -> void:
	editing_attribute_item_res.item_name=name_lineEdit.text
	change()


func _on_icon_file_line_edit_file_path_changed(new_path: String) -> void:
	editing_attribute_item_res.item_icon_path=new_path
	change()

func _on_description_text_edit_text_changed() -> void:
	editing_attribute_item_res.item_description=description_TextEdit.text


func _on_type_option_button_item_selected(index: int) -> void:
	if editing_attribute_item_res==null:
		return
	var new_class_name = type_OptionButtoon.get_item_text(index)
	if not attribute_factories.has(new_class_name):
		return
	var new_res:EB_BaseAttribute=attribute_factories[new_class_name].new()
	new_res.item_name=editing_attribute_item_res.item_name
	new_res.item_icon_path=editing_attribute_item_res.item_icon_path
	new_res.item_description=editing_attribute_item_res.item_description
	var res_key=res.attribute_dict.find_key(editing_attribute_item_res)
	res.attribute_dict[res_key]=new_res
	editing_attribute_item_res=new_res
	reload()
	_reload_edit_view(new_res)
	change()


func _on_save_button_pressed() -> void:
	editor.save_to_file(file_path)
