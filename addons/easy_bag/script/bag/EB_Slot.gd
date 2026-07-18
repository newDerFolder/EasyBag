class_name EB_Slot extends EB_BaseInventory

var item: EB_InventoryItem = null

@export var allowed_tags: Array[EB_BaseTag] = []

signal slot_change()


func move_item_to_inventory(to_inventory: EB_BaseInventory, item: EB_InventoryItem = null) -> bool:
	if item == null:
		item = self.item
	if item == null or to_inventory == null:
		return false
	
	if to_inventory.receive_item_from_inventory(item):
		self.item = null
		slot_change.emit()  # ✅ 发射信号
		return true
	return false


func receive_item_from_inventory(item: EB_InventoryItem) -> bool:
	if item == null or self.item != null:
		return false
	
	if not _can_accept_item(item):
		return false
	
	self.item = item
	slot_change.emit()  # ✅ 发射信号
	return true


func replace_item(new_item: EB_InventoryItem) -> EB_InventoryItem:
	if new_item == null:
		return null
	
	if not _can_accept_item(new_item):
		return null
	
	var old_item = self.item
	self.item = new_item
	slot_change.emit()
	return old_item


func _can_accept_item(item: EB_InventoryItem) -> bool:
	if allowed_tags.is_empty():
		return true
	
	for tag in allowed_tags:
		if not item.has_tag_by_name(tag.tag_name):
			return false
	return true


func get_all_items() -> Array[EB_InventoryItem]:
	if item == null:
		return []
	return [item]
