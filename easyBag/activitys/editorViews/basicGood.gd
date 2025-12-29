extends PanelContainer

var mainNode:Object
var id

@onready var la_id:Label=$VBoxContainer/info/idLabel
@onready var tr_icon:TextureRect=$VBoxContainer/info/itemIcon
@onready var tb_editIcon:TextureButton=$VBoxContainer/info/editIcon
@onready var rl_name:RichTextLabel=$VBoxContainer/info/itemName
@onready var tb_editName:TextureButton=$VBoxContainer/info/editName

@onready var tagsFH:HFlowContainer=$VBoxContainer/tags/tags
@onready var tb_editTags:TextureButton=$VBoxContainer/tags/editTags
@onready var attributesFH:HFlowContainer=$VBoxContainer/attributes/attributes
@onready var tb_editAttributes:TextureButton=$VBoxContainer/attributes/editAttributes

@onready var rl_des:RichTextLabel=$VBoxContainer/des/FlowContainer/itemdescription
@onready var tb_editDes:TextureButton=$VBoxContainer/des/FlowContainer/editDescription




@abstract class dataManager:
	var mainNode
	var itemId
	var dataId
	@abstract func updata(id,newData)
	func _init(mainNode,itemId) -> void:
		self.mainNode=mainNode
		self.itemId=itemId
		self.dataId=dataId
class TagsManager extends dataManager:
	func updata(id,newData):
		pass
class AttributesManager extends dataManager:
	func updata(id,newData):
		mainNode.itemData[itemId]["attributesVal"][id]["val"]=newData
var tagsManager
var attributesManager


func get_dataDict()->Dictionary:
	return mainNode.itemData[id]

func get_data(dataName):
	return mainNode.itemData[id][dataName]

func _ready() -> void:
	tagsManager=TagsManager.new(mainNode,id)
	attributesManager=AttributesManager.new(mainNode,id)
	change()
	changeUi()

func fold_description():
	$VBoxContainer/des.fold()

func changeUi():
	if mainNode.editItem:
		tb_editIcon.visible=true
		tb_editName.visible=true
		tb_editDes.visible=true
		tb_editTags.visible=true
		tb_editAttributes.visible=true
		for i in attributesFH.get_children():
			i.editVal=true
	else:
		tb_editIcon.visible=false
		tb_editName.visible=false
		tb_editDes.visible=false
		tb_editTags.visible=false
		tb_editAttributes.visible=false
		for i in attributesFH.get_children():
			i.editVal=false

func change():
	la_id.text=id
	rl_name.text=get_data("name")
	tr_icon.texture=load(get_data("iconPath"))
	rl_des.text=get_data("description")
	for i in tagsFH.get_children():
		i.queue_free()
	for i in attributesFH.get_children():
		i.queue_free()
	for i in mainNode.itemData[id]["tags"]:
		var tagTtem=load("res://easyBag/scene/TagItemView.tscn").instantiate()
		tagTtem.id=i
		tagTtem.mainNode=mainNode
		tagTtem.editNode=tagsManager
		tagsFH.add_child(tagTtem)
	for i in mainNode.itemData[id]["attributes"]:
		var attributesItem=load("res://easyBag/scene/attributeItemView.tscn").instantiate()
		attributesItem.id=i
		attributesItem.showVal=true
		attributesItem.editVal=mainNode.editItem
		attributesItem.mainNode=mainNode
		attributesItem.editNode=attributesManager
		attributesItem.fromItem=id
		attributesFH.add_child(attributesItem)

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
