class_name EB_WindowFactory extends EB_BaseFactory


#HACK:以后可以把创建加属性弹窗优化到工厂里
func create_add_attribute_window_for_codex(editor_ui:EB_CodexEditorUi)->EB_CodexAddAttributeWindow:
	var new_wim:EB_CodexAddAttributeWindow=preload("res://addons/easy_bag/scene/window/AddAttribute.tscn").instantiate()
	new_wim
	return


static func create_add_tag_window_for_codex(editor_ui:EB_CodexEditorUi)->EB_CodexAddTagWindow:
	var new_win:EB_CodexAddTagWindow=preload("res://addons/easy_bag/scene/window/AddTag.tscn").instantiate()
	new_win.codex_editorUi=editor_ui
	new_win.codex_editor=editor_ui.editor
	new_win.codex=new_win.codex_editor.res
	new_win.tag_set=new_win.codex.linked_tag_set
	new_win.codex_item_res=editor_ui.editing_codex_item_res
	return new_win
