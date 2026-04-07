extends PanelContainer
class_name EB_TagItemNode

@onready var tag_icon:=$VBC/HFC/TextureRect
@onready var tag_name_lab:=$VBC/HFC/Label
@onready var childrenTags_VBC:=$VBC/FoldableContainer/VBC

var res:EB_Tag=null



signal select_item_button_pressed(res: EB_Tag, node: Control, event: InputEvent)

func change():
	if res==null:
		push_error("EB_TagItemNode的res:EB_Tag为null")
		return
	if ResourceLoader.exists(res.item_icon_path):
		tag_icon.texture=load(res.item_icon_path)
	tag_name_lab.text=res.tag_name
	tooltip_text=res.tag_description

func _ready() -> void:
	change()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			select_item_button_pressed.emit(res, self, event)
func change_select(toggled_on:bool):
	EB_ItemNodeTweenPlayer.update_item_node_visuals(self,toggled_on)
	change()


func _on_mouse_entered() -> void:
	EB_ItemNodeTweenPlayer.mouse_entered(self)
