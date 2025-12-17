@icon("res://easyBag/sc/easyBagIcon.png")
extends Control

var itemData:Dictionary=EasyBag.createCodex()
var kind="codex"

var itemGColumns=1
var itemScale=1

var tagsData={"basicItem":{"name":"basicItem","iconPath":"","extends":"","inherentAttribute":["maxStack"],"description":""},
"food":{"name":"food","iconPath":"","extends":"basicItem","inherentAttribute":[],"description":""}}
var attributesData={"maxStack":{"name":"maxStack","iconPath":"res://easyBag/sc/iconStack.png","kind":"int","val":64,"static":true,"fromTag":"basicItem","description":"影响一个物品储存格中最多存储该物品的数量上限"},
"hp":{"name":"hp","iconPath":"res://easyBag/sc/hpIcon.png","kind":"int","val":100,"static":true,"fromTag":"","description":"角色的生命值，耗尽则代表死亡，防具中通常来表示能够提升的血量上限"}}

var editItem=false

var filePath:String



func _ready() -> void:
	loadEasybagData()
	change()
func _process(delta: float) -> void:
	changeUi()
func change():
	for i in get_children():
		i.change()
func updata():
	pass
func changeUi():
	$toolbar.size.x=size.x
	$rightSidebar.size.y=size.y-$toolbar.size.y
	$rightSidebar.position.y=$toolbar.size.y+5
	$items.position.y=$toolbar.size.y+5
	$items.size.y=size.y-$toolbar.size.y-5
	$items.size.x=size.x-$rightSidebar.size.x-5
	for i in get_children():
		i.changeUi()
func beNewFile():
	get_tree().change_scene_to_file("res://easyBag/activitys/editor.tscn")
	print("easyBag:new")
func fold_description():
	$items.fold_description()



func _on_cb_edit_mode_pressed() -> void:
	if editItem:
		editItem=false
	else:
		editItem=true
	changeUi()
	pass # Replace with function body.

func loadFile(path):
	var dict=EasyBag.loadFile(path)
	itemData=dict["data"]
	kind=dict["kind"]
	filePath=dict["path"]
	change()
	changeUi()

func loadEasybagData():
	var easybag_data=EasyBag.loadEasybagData()
	if easybag_data==null:
		return
	if easybag_data.has("tagsData"):
		tagsData=easybag_data["tagsData"]
		attributesData=easybag_data["attributesData"]
func saveEasybagData():
	var save_data:Dictionary
	save_data["tagsData"]=tagsData
	save_data["attributesData"]=attributesData
	EasyBag.saveEasybagData(save_data)
