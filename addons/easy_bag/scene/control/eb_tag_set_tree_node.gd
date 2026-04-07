extends ScrollContainer
class_name EB_TagSetTreeNode

@onready var item_VBC:=$VBoxContainer

var tag_set:EB_TagSet
var items_select_group:SelectGroup=SelectGroup.new()

func _ready() -> void:
	items_select_group.select_mode=items_select_group.Select_Mode.MULTIPLE
	reload()

func reload():
	for i in item_VBC.get_children():
		i.queue_free()
	for i in tag_set.tag_dict:
		var tag:EB_Tag=tag_set.tag_dict[i]
		if tag.extends_tag_id=="":
			add_new_item_node(tag)

func add_new_item_node(tag:EB_Tag):
	var tag_node:EB_TagItemNode=preload("res://addons/easy_bag/scene/control/EbTagSetItemNode.tscn").instantiate()
	tag_node.res=tag
	tag_node.select_item_button_pressed.connect(_item_selected)
	item_VBC.add_child(tag_node)


func _item_selected(item_res: EB_Tag, node: Control, event: InputEvent):
	items_select_group.select(node, event.ctrl_pressed, event.shift_pressed)
