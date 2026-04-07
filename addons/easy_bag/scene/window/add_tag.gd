extends ConfirmationDialog
class_name EB_CodexAddTagWindow

var tag_set:EB_TagSet
var codex:EB_Codex
var codex_editor:EB_CodexEditor
var codex_editorUi:EB_CodexEditorUi

func _ready() -> void:
	var tag_tree=preload("res://addons/easy_bag/scene/control/EB_TagSetTreeNode.tscn").instantiate()
	tag_tree.tag_set=tag_set
	add_child(tag_tree)
	#add_child(Button.new())
