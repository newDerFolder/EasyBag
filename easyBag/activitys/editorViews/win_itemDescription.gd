extends ConfirmationDialog

var oldData
var editNode:Object
var editData:String
var mainNode

@onready var le_name=$VBoxContainer/LineEdit

func _ready() -> void:
	le_name.text=oldData
	le_name.grab_focus()
	pass

func changeUi():
	pass

func _on_confirmed() -> void:
	queue_free()
	pass # Replace with function body.


func _on_canceled() -> void:
	updata(oldData)
	queue_free()
	pass # Replace with function body.

func updata(new_data):
	print("updata")
	editNode.get_dataDict()[editData]=new_data
	editNode.change()

func _on_line_edit_text_changed() -> void:
	updata(le_name.text)
	pass # Replace with function body.
