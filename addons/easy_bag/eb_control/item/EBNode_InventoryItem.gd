extends Button
class_name EBNode_InventoryItem

var res:EB_InventoryItem

func _init(res:EB_InventoryItem) -> void:
	self.res=res

func _ready() -> void:
	text=res.get_item_name()
	tooltip_text=res.get_item_description()
	icon=load(res.get_item_icon_path())
