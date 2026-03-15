extends PanelContainer

@export var linked_item_res:EB_CodexItem

@onready var item_icon:TextureRect=$HBoxContainer/TextureRect
@onready var item_name:Label=$HBoxContainer/Label


signal select_item_button_pressed(codex_item:EB_CodexItem,node: Control)


func _ready() -> void:
	change()

func change():
	if linked_item_res==null:
		return
	if ResourceLoader.exists(linked_item_res.item_icon_path):
		item_icon.texture=load(linked_item_res.item_icon_path)
	tooltip_text=linked_item_res.item_description
	item_name.text=linked_item_res.item_name

##回调方法
func change_select(toggled_on:bool):
	EB_ItemNodeTweenPlayer.update_item_node_visuals(self,toggled_on)
	change()





func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			change_select(true)
			EB_ItemNodeTweenPlayer.mouse_pressed(self)
			select_item_button_pressed.emit(linked_item_res,self)


func _on_mouse_entered() -> void:
	EB_ItemNodeTweenPlayer.mouse_entered(self)
