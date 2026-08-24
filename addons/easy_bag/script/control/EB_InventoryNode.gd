class_name EB_InventoryNode extends HFlowContainer

@export var inventory: EB_Inventory
	#set(value):
		#if inventory:
			#inventory.inventory_change.disconnect(_on_inventory_change)
		#inventory = value
		#if inventory and is_inside_tree():
			#inventory.inventory_change.connect(_on_inventory_change)
			#refresh()

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
		add_child(item_node)

func _on_inventory_change() -> void:
	refresh()
