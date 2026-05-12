extends EB_BaseFactory
class_name EB_EditorFactory

func create(res:EasyBagResource)->EB_BaseEditor:
	if res==null:
		push_error("EB_EditorFactory的方法收到的res为null")
		return
	if res is EB_Codex:
		return _create_CodexEditor(res)
	elif res is EB_AttributeSet:
		return _create_AttributeSetEditor(res)
	elif res is EB_TagSet:
		return _create_TagSetEditor(res)
	else:
		push_error("EB_EditorFactory的方法收到了错误的res类型")
		return

func _create_CodexEditor(res:EB_Codex)->EB_CodexEditor:
	var new_editor:EB_CodexEditor=EB_CodexEditor.new()
	new_editor.res=res
	return new_editor
func _create_AttributeSetEditor(res:EB_AttributeSet)->EB_AttributeSetEditor:
	var new_editor:EB_AttributeSetEditor=EB_AttributeSetEditor.new()
	new_editor.res=res
	return new_editor
func _create_TagSetEditor(res:EB_TagSet)->EB_TagSetEditor:
	var new_editor:EB_TagSetEditor=EB_TagSetEditor.new()
	new_editor.res=res
	return new_editor
