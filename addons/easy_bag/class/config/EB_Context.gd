extends RefCounted
class_name EB_EditorNodeContext

var main_editor_ui_node:EB_MainEditorUi
var previous_editor_ui_node:EB_BaseEditorUi
var now_editor_ui_node:EB_BaseEditorUi
var should_reload_on_return =false
#是否需要在返回Codex编辑器时重新加载(用于在改完属性集合后再切换回Codex时更改)

func change_editorNode(new_editor_node:EB_BaseEditorUi):
	if now_editor_ui_node==null:
		now_editor_ui_node=new_editor_node
	else:
		previous_editor_ui_node=now_editor_ui_node
		now_editor_ui_node=new_editor_node
