extends ConfirmationDialog
class_name EB_CodexAddTagWindow

var tag_set:EB_TagSet
var codex:EB_Codex
var codex_item_res:EB_CodexItem
var codex_editor:EB_CodexEditor
var codex_editorUi:EB_CodexEditorUi


var tag_tree:EB_TagSetTreeNode

func _ready() -> void:
	tag_tree=preload("res://addons/easy_bag/scene/control/EB_TagSetTreeNode.tscn").instantiate()
	tag_tree.tag_set=tag_set
	add_child(tag_tree)
	#add_child(Button.new())


func _on_canceled() -> void:
	queue_free()
	pass # Replace with function body.


func _on_confirmed() -> void:
	var item_tag_list:Array[EB_ItemTag];
	for i in tag_tree.get_selected_tags():
		item_tag_list.append(tag_set.get_item_tag_by_set_tag(i))
	codex_editor.add_new_tag_items(codex_item_res,item_tag_list)
