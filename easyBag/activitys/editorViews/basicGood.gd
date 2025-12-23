extends PanelContainer

var mainNode:Object
var id
#
#var iconPath:String
#var goodName:String
#var description:String
#var tags:Array
#var maxStack:int
#var more:Dictionary

func get_dataDict()->Dictionary:
	return mainNode.itemData[id]

func get_data(dataName):
	return mainNode.itemData[id][dataName]

func _ready() -> void:
	change()
	changeUi()

func fold_description():
	$GridContainer/FoldableContainer.fold()

func changeUi():
	for i in get_children():
		i.changeUi()

func change():
	$GridContainer/itemName.text=get_data("name")
	$GridContainer/itemIcon.texture=load(get_data("iconPath"))
	$GridContainer/FoldableContainer/FlowContainer/itemdescription.text=get_data("description")
	for i in $GridContainer/tags.get_children():
		i.queue_free()
	for i in mainNode.itemData[id]["tags"]:
		var tagTtem=load("res://easyBag/scene/TagItemView.tscn").instantiate()
		tagTtem.id=i
		tagTtem.mainNode=mainNode
		$GridContainer/tags.add_child(tagTtem)
	for i in mainNode.itemData[id]["attributes"]:
		var attributesItem=load("res://easyBag/scene/attributeItemView.tscn").instantiate()
		attributesItem.id=i
		attributesItem.showVal=true
		attributesItem.editVal=mainNode.editItem
		attributesItem.mainNode=mainNode
		$GridContainer/attributes.add_child(attributesItem)

func _on_mouse_entered() -> void:
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	pass # Replace with function body.


func _on_edit_name_pressed() -> void:
	var namewin=load("res://easyBag/activitys/editorViews/win_itemName.tscn").instantiate()
	namewin.mainNode=mainNode
	namewin.editNode=self
	namewin.oldData=get_data("name")
	namewin.editData="name"
	mainNode.add_child(namewin)
	pass # Replace with function body.


func _on_edit_icon_pressed() -> void:
	var cdwin=load("res://easyBag/activitys/editorViews/win_itemIcon.tscn").instantiate()
	cdwin.mainNode=mainNode
	cdwin.editNode=self
	cdwin.oldData=get_data("iconPath")
	cdwin.editData="iconPath"
	mainNode.add_child(cdwin)
	pass # Replace with function body.


func _on_edit_description_pressed() -> void:
	var cdwin=load("res://easyBag/activitys/editorViews/win_itemDescription.tscn").instantiate()
	cdwin.mainNode=mainNode
	cdwin.editNode=self
	cdwin.oldData=get_data("description")
	cdwin.editData="description"
	mainNode.add_child(cdwin)
	pass # Replace with function body.


func _on_edit_tags_pressed() -> void:
	var cdwin=load("res://easyBag/windows/editItemTags.tscn").instantiate()
	cdwin.mainNode=mainNode
	cdwin.oldData=get_data("tags")
	cdwin.editData=id
	mainNode.add_child(cdwin)
	pass # Replace with function body.


func _on_edit_attributes_pressed() -> void:
	var cdwin=load("res://easyBag/windows/editItemAttributes.tscn").instantiate()
	cdwin.mainNode=mainNode
	cdwin.oldData=get_data("attributes")
	cdwin.editData=id
	mainNode.add_child(cdwin)
	pass # Replace with function body.
