extends EasyBagResource
class_name EB_TagSet

@export var tag_dict:Dictionary[String,EB_Tag]


func get_item_tag_by_id(target_id: String) -> EB_ItemTag:
	if not tag_dict.has(target_id):
		push_error("EB_Codex: No item found with ID '%s'" % target_id)
		return null
	return EB_TagFactory.create_item_tag(target_id)

func get_item_tag_by_set_tag(set_tag:EB_Tag) -> EB_ItemTag:
	if set_tag==null:
		push_error("EB_Codex: 传入为null的set_tag")
		return
	var tag_id=tag_dict.find_key(set_tag)
	return EB_TagFactory.create_item_tag(tag_id)
