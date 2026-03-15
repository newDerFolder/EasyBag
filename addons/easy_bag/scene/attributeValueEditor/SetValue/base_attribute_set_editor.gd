extends VBoxContainer

@export var res:EB_IntAttribute 

func _ready() -> void:
	if res==null:
		return
	$HBoxContainer/CheckButton.button_pressed=res.default_static




func _on_check_button_toggled(toggled_on: bool) -> void:
	res.default_static=toggled_on
