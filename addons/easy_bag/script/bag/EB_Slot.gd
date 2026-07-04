class_name EB_Slot extends EB_BaseInventory

var item: EB_InventoryItem = null

@export var allowed_tags: Array[EB_BaseTag] = []


func replace_item(new_item: EB_InventoryItem) -> EB_InventoryItem:
	# 如果设置了允许标签，检查新物品是否全部拥有
	if allowed_tags.size() > 0:
		for tag in allowed_tags:
			if not new_item.has_tag_by_name(tag.tag_name):
				return new_item  # 不满足条件，原路返回

	var old_item = item
	item = new_item
	return old_item
