extends VBoxContainer

@export var res:EB_IntAttribute 
@onready var default_value_spinBox:SpinBox=$HBoxContainer/DefaultValueSpinBox

func _ready() -> void:
	if res==null:
		return
	default_value_spinBox.value=float(res.default_value)

func _on_spin_box_value_changed(value: float) -> void:
	res.default_value=int(value)
