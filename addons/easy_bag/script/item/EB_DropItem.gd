## @experimental
@icon("res://addons/easy_bag/asset/icon/DropItem.png")
class_name EB_DropItem extends EB_BaseItem
## 掉落项,通常放在 EB_DropPool 中

@export var drop_weight:int=1
@export var item:EB_InventoryItem

func create_instance()->EB_InventoryItem:
	return item.clone_self()
