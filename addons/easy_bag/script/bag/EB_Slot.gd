class_name EB_Slot extends EB_BaseInventory

var item:EB_InventoryItem=null



func replace_item(new_item:EB_InventoryItem)->EB_InventoryItem:
	var old_item=item
	item=new_item
	return old_item
