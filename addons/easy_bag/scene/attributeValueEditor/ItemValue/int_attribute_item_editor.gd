extends EB_CodexBaseAttributeValueEditorUi
@onready var item_value=$HFlowContainer/SpinBox


func _ready() -> void:
	if not res is EB_ItemIntAttribute:
		visible=false
	super()


func change():
	super()
	item_value.value=res.value


func _on_spin_box_value_changed(value: float) -> void:
	res.value=int(value)
	pass # Replace with function body.
