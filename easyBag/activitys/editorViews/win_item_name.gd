extends ConfirmationDialog

var oldData
var editNode:Object
var editData:String
var mainNode

@onready var le_name=$VBoxContainer/LineEdit
@onready var cb_changeId=$VBoxContainer/CheckBox

func _ready() -> void:
	le_name.grab_focus()
	pass

func changeUi():
	pass

func _on_confirmed() -> void:
	if cb_changeId.button_pressed:
		if le_name.text=="":
			$VBoxContainer/l_idCantEmpty.visible=true
			return
		mainNode.itemData[le_name.text]=editNode.get_dataDict().duplicate(true)
		mainNode.itemData.erase(editNode.id)
		editNode.id=le_name.text
	else:
		pass
	
	queue_free()
	pass # Replace with function body.


func _on_canceled() -> void:
	updata(oldData)
	queue_free()
	pass # Replace with function body.

func updata(new_data):
	editNode.get_dataDict()[editData]=new_data
	editNode.change()

func _on_line_edit_text_changed(new_text: String) -> void:
	updata(new_text)
	pass # Replace with function body.
