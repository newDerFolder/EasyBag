extends PanelContainer
class_name EB_TagItemNode

@onready var tag_icon:=$VBoxContainer/HFlowContainer/TextureRect
@onready var tag_name_lab:=$VBoxContainer/HFlowContainer/Label

@export var extends_tag_id:String=""
var res:EB_Tag=null


func change():
	if ResourceLoader.exists(res.item_icon_path):
		tag_icon.texture=load(res.item_icon_path)
	tag_name_lab.text=res.tag_name
	extends_tag_id=res.tag_extends_id
