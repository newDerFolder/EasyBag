@tool
extends HBoxContainer
class_name FileLineEdit

var line_edit: LineEdit = LineEdit.new()
var select_button: Button = Button.new()
var file_dialog: FileDialog = FileDialog.new()

# 使用getter/setter来保持同步
var file_path: String:
	get:
		return line_edit.text
	set(value):
		line_edit.text = value

signal file_path_changed(new_path: String)

@export var file_mode: FileDialog.FileMode = FileDialog.FileMode.FILE_MODE_SAVE_FILE

func _ready() -> void:
	line_edit.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	select_button.text = "select"
	add_child(line_edit)
	add_child(select_button)
	add_child(file_dialog)
	
	if not select_button.pressed.is_connected(_select_button_pressed):
		select_button.pressed.connect(_select_button_pressed)
	if not line_edit.text_changed.is_connected(_on_line_edit_text_changed):
		line_edit.text_changed.connect(_on_line_edit_text_changed)
	if not file_dialog.dir_selected.is_connected(_on_file_dialog_dir_selected):
		file_dialog.dir_selected.connect(_on_file_dialog_dir_selected)
		file_dialog.file_selected.connect(_on_file_dialog_file_selected)

func _on_file_dialog_dir_selected(dir: String):
	file_path = dir  # 使用setter自动更新line_edit
	file_path_changed.emit(dir)

func _on_file_dialog_file_selected(path: String):
	file_path = path  # 使用setter自动更新line_edit
	file_path_changed.emit(path)

func _select_button_pressed():
	file_dialog.file_mode = file_mode
	file_dialog.initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_MAIN_WINDOW_SCREEN
	file_dialog.popup()

func _on_line_edit_text_changed(new_text: String):
	file_path_changed.emit(new_text)
