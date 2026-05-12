extends EB_BaseFactory
class_name EB_EditorNodeFactory

func create(editor: EB_BaseEditor) -> EB_BaseEditorUi:
	if editor == null:
		push_error("[EB_EditorNodeFactory] 传入的 editor 为 null")
		return null
		
	if editor is EB_CodexEditor:
		return _create_codex_ui(editor)
	elif editor is EB_AttributeSetEditor:
		return _create_attribute_ui(editor)
	elif editor is EB_TagSetEditor:
		return _create_tag_ui(editor)
	else:
		push_error("[EB_EditorNodeFactory] 未知的 Editor 类型: ", editor.get_class())
		return null

func _initialize_ui(ui: EB_BaseEditorUi, editor: EB_BaseEditor):
	ui.editor = editor
	ui.res = editor.res

func _create_codex_ui(editor: EB_CodexEditor) -> EB_CodexEditorUi:
	var ui = EB_CodexEditorUi.new()
	_initialize_ui(ui, editor)
	return ui
func _create_attribute_ui(editor: EB_AttributeSetEditor) -> EB_AttributeSetEditorUi: # 假设你有这个类
	var ui = EB_AttributeSetEditorUi.new()
	_initialize_ui(ui, editor)
	return ui

func _create_tag_ui(editor: EB_TagSetEditor) -> EB_TagSetEditorUi: # 假设你有这个类
	var ui = EB_TagSetEditorUi.new()
	_initialize_ui(ui, editor)
	return ui
