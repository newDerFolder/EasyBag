extends EB_BaseItem
class_name EB_CodexItem

@export var item_icon_path:String=""
@export var item_name:String="a new item"
@export var item_description:String=""
@export var tag_dict:Dictionary[String,EB_ItemTag]
@export var attribute_dict:Dictionary[String,EB_ItemBaseAttribute]


func get_all_item_tag()->Array[EB_ItemTag]:
	var tag_arr:Array[EB_ItemTag]=[]
	for i in tag_dict:
		tag_arr.append(tag_dict[i])
	return tag_arr
func get_all_item_attribute()->Array[EB_ItemBaseAttribute]:
	var attribute_arr:Array[EB_ItemBaseAttribute]=[]
	for i in attribute_dict:
		attribute_arr.append(attribute_dict[i])
	return attribute_arr
