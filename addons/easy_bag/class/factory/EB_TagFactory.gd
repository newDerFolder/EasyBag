extends EB_BaseFactory
class_name EB_TagFactory


static func create_item_tag(new_id:String)->EB_ItemTag:
	var item_tag=EB_ItemTag.new()
	item_tag.tag_id=new_id
	return item_tag
