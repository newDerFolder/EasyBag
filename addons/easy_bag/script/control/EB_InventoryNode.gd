class_name EB_InventoryNode extends HFlowContainer

@export var inventory: EB_Inventory
	#set(value):
		#if inventory:
			#inventory.inventory_change.disconnect(_on_inventory_change)
		#inventory = value
		#if inventory and is_inside_tree():
			#inventory.inventory_change.connect(_on_inventory_change)
			#refresh()

signal item_selected(item:EB_InventoryItem)


func link_inventory_res(inventory: EB_Inventory):
	self.inventory=inventory
	refresh()

func _on_item_selected(item:EB_InventoryItem):
	item_selected.emit(item)

func _ready() -> void:
	if inventory:
		inventory.inventory_change.connect(_on_inventory_change)
		refresh()

func refresh() -> void:
	for i in get_children():
		i.queue_free()
	if inventory == null:
		return
	for i in inventory.get_all_items():
		var item_node = EB_InventoryItemButtonNode.new()
		item_node.item = i
		item_node.item_selected.connect(_on_item_selected)
		add_child(item_node)

func _on_inventory_change() -> void:
	refresh()
