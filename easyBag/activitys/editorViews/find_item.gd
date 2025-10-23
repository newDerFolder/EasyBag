extends PanelContainer

var mainNode


func _on_sp_grid_columns_value_changed(value: float) -> void:
	mainNode.itemGColumns=int(value)
	mainNode.changeUi()
func _on_colunm_1_pressed() -> void:
	mainNode.itemGColumns=1
	mainNode.changeUi()
	$VBoxContainer/view.change()
func _on_colunm_2_pressed() -> void:
	mainNode.itemGColumns=2
	mainNode.changeUi()
	$VBoxContainer/view.change()
func _on_colunm_4_pressed() -> void:
	mainNode.itemGColumns=4
	mainNode.changeUi()
	$VBoxContainer/view.change()
func _on_colunm_8_pressed() -> void:
	mainNode.itemGColumns=8
	mainNode.changeUi()
	$VBoxContainer/view.change()
func _on_btn_fold_des_pressed() -> void:
	mainNode.fold_description()
	pass # Replace with function body.
