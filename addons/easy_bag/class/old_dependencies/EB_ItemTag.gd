## @deprecated
@icon("res://addons/easy_bag/asset/icon/TagIcon.png")
class_name EB_ItemTag extends EB_BaseItem

@export var tag_id: String

# 修复了字典查找的键，并规范了返回类型
func get_set_tag(tag_set: EB_TagSet) -> EB_Tag:
	if tag_set == null:
		push_error("ItemTag:传入的tag_set为null")
		return null
	# 修复：这里应该查找 tag_id，而不是 tag_set 对象本身
	if not tag_set.tag_dict.has(tag_id):
		push_error("ItemTag:访问的TagSet没有对应键: " + tag_id)
		return null
	else:
		return tag_set.tag_dict[tag_id]

func get_tag_name(tag_set: EB_TagSet):
	var tag = get_set_tag(tag_set)
	# 增加空值判断，防止崩溃
	if tag == null:
		return null
	return tag.tag_name # 加上 return

func get_tag_description(tag_set: EB_TagSet):
	var tag = get_set_tag(tag_set)
	if tag == null:
		return null
	return tag.tag_description # 加上 return

func get_tag_icon_path(tag_set: EB_TagSet):
	var tag = get_set_tag(tag_set)
	if tag == null:
		push_error("获取图标路径失败：tag为null")
		return null
	return tag.item_icon_path # 加上 return
