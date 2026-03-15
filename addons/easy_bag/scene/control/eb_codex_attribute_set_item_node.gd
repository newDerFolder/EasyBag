extends PanelContainer

@export var res:EB_BaseAttribute

@onready var item_icon=$HFlowContainer/TextureRect
@onready var item_name=$HFlowContainer/Label


# 修改信号定义，增加一个 event 参数
signal select_item_button_pressed(res: EB_BaseAttribute, node: Control, event: InputEvent)

func _ready() -> void:
	change()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# 将 event 传出去，这样管理类才知道你有没有按住 Ctrl
			select_item_button_pressed.emit(res, self, event)

func change():
	if res==null:
		return
	if ResourceLoader.exists(res.item_icon_path):
		item_icon.texture=load(res.item_icon_path)
	tooltip_text=res.item_description
	item_name.text=res.item_name
func change_select(toggled_on:bool):
	EB_ItemNodeTweenPlayer.update_item_node_visuals(self,toggled_on)
	change()




func _on_mouse_entered() -> void:
	EB_ItemNodeTweenPlayer.mouse_entered(self)
