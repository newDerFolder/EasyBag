extends ConfirmationDialog

var old_text:String=""
var codex_item_res:EB_CodexItem

@onready var line_edit:LineEdit=$LineEdit

func _ready() -> void:
	line_edit.text=old_text
	line_edit.grab_focus()

func _on_canceled() -> void:
	queue_free()
	pass # Replace with function body.

func _on_confirmed() -> void:
	codex_item_res.item_name=line_edit.text
	pass # Replace with function body.
