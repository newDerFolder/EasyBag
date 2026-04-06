extends EB_BaseEditorUi
class_name EB_TagEditorUi

@onready var item_VBC:=$HSplitContainer/item/ScrollContainer/VBoxContainer

var type_res:EB_TagSet
var type_editor:EB_TagSetEditor

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
	for i in type_res.tag_dict:
		var tag:EB_Tag=type_res.tag_dict[i]
		if tag.extends_tag_id=="":
			var tag_node=preload("res://addons/easy_bag/scene/control/EbTagSetItemNode.tscn").instantiate()
			item_VBC.add_child(tag_node)


func _on_save_button_pressed() -> void:
	type_editor.save_to_file(file_path)


func _on_add_root_tag_button_pressed() -> void:
	type_editor.add_new_item()
	reload()
