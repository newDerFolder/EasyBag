extends Control

var itemData:Dictionary=EasyBag.createCodex()
var kind="codex"

var itemGColumns=1
var itemScale=1

var tagsData={}

var editItem=false

var filePath:String

func _ready() -> void:
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
