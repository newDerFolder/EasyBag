extends ConfirmationDialog

signal scene_created(editor_scene)

var new_editor
var res_class

func _select_path(class_file_path:String):
	res_class=class_file_path
	var file_dialog=FileDialog.new()
	add_child(file_dialog)
	
	var target_dir = "res://addons/easy_bag/workfile/" + class_file_path+"/"
	if not DirAccess.dir_exists_absolute(target_dir):
		DirAccess.make_dir_recursive_absolute(target_dir)
	file_dialog.current_dir = target_dir
	
	file_dialog.add_filter("*.tres", "Godot Resource")
	file_dialog.file_mode=FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.initial_position=Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	file_dialog.access = FileDialog.ACCESS_RESOURCES
	file_dialog.file_selected.connect(_file_dialog_file_selected)
	file_dialog.popup()



func _file_dialog_file_selected(path: String):
	if not path.ends_with(".tres"):
		path += ".tres"
	var new_class_res
	match res_class:
		"Codex":
			new_class_res=EB_Codex.new()
			new_editor.file_path=path
			new_editor.res=new_class_res
		"AttributeSet":
			new_class_res=EB_AttributeSet.new()
			new_editor.file_path=path
			new_editor.res=new_class_res
	ResourceSaver.save(new_class_res,path)
	
	scene_created.emit(new_editor)
	queue_free()
	



func _on_create_codex_pressed() -> void:
	new_editor=preload("res://addons/easy_bag/activity/CodexEditor.tscn").instantiate()
	_select_path("Codex")
	pass # Replace with function body.


func _on_create_codex_attribute_set_pressed() -> void:
	new_editor=preload("res://addons/easy_bag/activity/AttributeEditor.tscn").instantiate()
	_select_path("AttributeSet")
	pass # Replace with function body.
