extends ConfirmationDialog

var oldData
var editNode:Object
var editData:String
var mainNode

@onready var le_icon=$HFlowContainer/LineEdit


func _ready() -> void:
	le_icon.grab_focus()
	pass

func changeUi():
	pass

func _on_confirmed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_canceled() -> void:
	updata(oldData)
	queue_free()
	pass # Replace with function body.

func updata(new_data):
	editNode.get_dataDict()[editData]=new_data
	editNode.change()

func _on_line_edit_text_changed(new_text: String) -> void:
	updata(new_text)
	pass # Replace with function body.


func _on_texture_button_pressed() -> void:
	var file_dialog = FileDialog.new()
	add_child(file_dialog)
	# 设置对话框的模式（例如，打开文件）
	file_dialog.file_mode = 0
	# 设置对话框的标题
	file_dialog.title = "选择文件"
	
	file_dialog.current_dir = "res://"
	# 设置允许的文件类型（可选）
	file_dialog.filters = [
		"*.png ; PNG 图片",
		"*.jpg, *.jpeg ; JPEG 图片",
		"*.bmp ; BMP 图片",
		"*.tga ; TGA 图片",
		"*.webp ; WebP 图片",
		"*.svg, *.svgz ; SVG 矢量图",
		"*.exr ; EXR 图片",
		"*.hdr ; HDR 图片",
		"*.dds ; DDS 纹理",
		"*.ktx, *.ktx2 ; KTX 纹理",
		"*.pkm ; PKM 压缩纹理",
		"*.pvr ; PVR 纹理",
		"*.basis ; Basis 通用纹理"
	]
	# 连接信号
	file_dialog.connect("file_selected", Callable(self, "_on_file_selected"))
	# 显示对话框
	file_dialog.popup_centered()
# 回调函数：当用户选择文件时触发
func _on_file_selected(path: String):
	$HFlowContainer/LineEdit.text=path
	updata(path)
