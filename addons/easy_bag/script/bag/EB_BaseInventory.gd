@abstract class_name EB_BaseInventory extends EasyBagResource


#@abstract func add_item(item:EB_InventoryItem)
#@abstract func get_all_items()->Array[EB_InventoryItem]

@abstract func move_item_to_inventory(to_inventory:EB_BaseInventory,item:EB_InventoryItem)->bool

@abstract func receive_item_from_inventory(item:EB_InventoryItem) -> bool
