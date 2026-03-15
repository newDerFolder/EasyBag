extends PanelContainer
class_name EB_CodexBaseAttributeValueEditorUi

var res:EB_ItemBaseAttribute
var set_res:EB_AttributeSet

@onready var item_icon=$HFlowContainer/TextureRect
@onready var item_name=$HFlowContainer/Label
@onready var item_static:CheckBox=$HFlowContainer/CheckBox
@onready var del_btn:Button=$HFlowContainer/Button

signal del_item_attribute(item_attribute_res:EB_ItemBaseAttribute)

func _ready() -> void:
	item_static.toggled.connect(_on_item_static_check_box_toggled)
	del_btn.pressed.connect(_on_del_btn_pressed)
	change()

func _on_del_btn_pressed():
	del_item_attribute.emit(res)
func _on_item_static_check_box_toggled(toggled:bool):
	res.is_static_attribute=toggled

func change():
	if res==null:
		return
	var root_res:EB_BaseAttribute=res.get_set_attribute(set_res)
	if ResourceLoader.exists(root_res.item_icon_path):
		item_icon.texture=load(root_res.item_icon_path)
	tooltip_text=root_res.item_description
	item_name.text=root_res.item_name
	
	if res.is_static_attribute:
		item_static.button_pressed=true
	else:
		item_static.button_pressed=false
