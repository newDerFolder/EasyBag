extends PanelContainer
class_name EB_CodexItemTagItemNode

@onready var tag_icon:=$HFC/TextureRect
@onready var tag_name:=$HFC/Label
@onready var del_btn:=$HFC/Button

var res:EB_ItemTag
var set_res:EB_TagSet

func _ready() -> void:
	change()

func change():
	if set_res==null:
		push_error("set_res 为null")
	var icon_path=res.get_tag_icon_path(set_res)
	if icon_path!="" or icon_path!=null:
		tag_icon.texture=load(res.get_tag_icon_path(set_res))
	tag_name.text=res.get_tag_name(set_res)
	tooltip_text=res.get_tag_description(set_res)
