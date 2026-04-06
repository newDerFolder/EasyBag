extends Node

var codex:EB_Codex=preload("res://addons/easy_bag/workfile/Codex/codex.tres")
var bag:EB_Inventory

func _ready() -> void:
	bag=ResourceLoader.load("user://bag.tres")
	if bag==null:
		bag=EB_Inventory.new()
	bag.link_codex(codex)
	refresh()

func refresh():
	for i in $ScrollContainer/GridContainer.get_children():
		i.queue_free()
	for i in bag.get_all_items():
		var itemNode=EBNode_InventoryItem.new(i)
		var stack=i.get_attribute_value(EBConfig_codex.苹果.堆叠)
		var stack_max=i.get_attribute_value(EBConfig_codex.苹果.堆叠上限)
		itemNode.pressed.connect(func():_on_item_click(i))
		print(stack)
		itemNode.text=itemNode.text+" "+str(stack)+"/"+str(stack_max)
		$ScrollContainer/GridContainer.add_child(itemNode)

func _on_item_click(item:EB_InventoryItem):
	item.get_attribute(EBConfig_codex.苹果.堆叠).value+=1
	refresh()

func _on_button_pressed() -> void:
	var newitem=codex.get_instantiate_InventoryItem(EBConfig_codex.苹果.new())
	bag.add_item(newitem)
	refresh()


func _on_button_2_pressed() -> void:
	ResourceSaver.save(bag,"user://bag.tres")
	pass # Replace with function body.


func _on_button_3_pressed() -> void:
	var newitem=codex.get_instantiate_InventoryItem_by_name("垃圾桶")
	if newitem==null:
		return
	bag.add_item(newitem)
	refresh()


func _on_button_4_pressed() -> void:
	var newitem=codex.get_instantiate_InventoryItem_by_id("1")
	bag.add_item(newitem)
	refresh()
