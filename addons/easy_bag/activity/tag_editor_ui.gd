extends EB_BaseEditorUi
class_name EB_TagEditorUi

@onready var item_VBC:=$HSplitContainer/item/ScrollContainer/VBoxContainer

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
	pass
func _change_item_node():
	for i in item_VBC.get_children():
		i.change()


func _on_save_button_pressed() -> void:
	type_editor.save_to_file(file_path)


func _on_add_root_tag_button_pressed() -> void:
	type_editor.add_new_item()
	reload()
