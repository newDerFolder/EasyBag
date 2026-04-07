extends EB_BaseFactory
class_name EB_EditorNodeFactory
#TODO:工厂建造中
func Create_TagEditorNode(context:EB_EditorNodeContext)->EB_TagEditorUi:
	var new_editor_node:=EB_TagEditorUi.new()
	new_editor_node.context=context
	return 
