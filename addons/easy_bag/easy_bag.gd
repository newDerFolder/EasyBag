@tool
extends EditorPlugin

const TARGET_SCENE_PATH := "res://addons/easy_bag/EasyBag.tscn"

var _launch_button: Button

func _enter_tree() -> void:
	var editor_interface = get_editor_interface()
	var base_control = editor_interface.get_base_control()
	
	# 1. 创建按钮
	_launch_button = Button.new()
	_launch_button.text = "EasyBag"
	_launch_button.tooltip_text = "点击运行: %s" % TARGET_SCENE_PATH
	_launch_button.flat = false 
	_launch_button.custom_minimum_size.x = 100
	
	if base_control.has_theme_icon("Play", "EditorIcons"):
		_launch_button.icon = base_control.get_theme_icon("Play", "EditorIcons")
	
	_launch_button.connect("pressed", _on_launch_button_pressed)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, _launch_button)
	
	print("按钮已添加到工具栏 (应紧贴帮助按钮附近)。")

func _exit_tree() -> void:
	if is_instance_valid(_launch_button):
		remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, _launch_button)
		_launch_button.queue_free()
		_launch_button = null

func _on_launch_button_pressed() -> void:
	if not ResourceLoader.exists(TARGET_SCENE_PATH):
		push_error("错误：场景文件不存在 -> " + TARGET_SCENE_PATH)
		get_editor_interface().get_resource_filesystem().scan()
		return
	
	get_editor_interface().play_custom_scene(TARGET_SCENE_PATH)
