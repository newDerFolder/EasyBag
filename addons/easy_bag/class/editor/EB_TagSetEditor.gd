extends EB_BaseEditor
class_name EB_TagSetEditor
# TODO:这个类施工中


var _type_res: EB_TagSet = null

var type_res:EB_TagSet:
	get:
		if _type_res == null:
			# 如果缓存为空，尝试从 res 获取
			if res != null and res is EB_TagSet:
				_type_res = res
			else:
				# 如果 res 也是空的，说明编辑器还没注入，或者出错了
				# 这里我们暂时返回 null，等待下一次访问
				push_warning("尝试访问 type_res 但资源尚未就绪")
				return null
		return _type_res
	set(val):
		_type_res = val



func add_new_item(id=null):
	if id==null:
		id="tag_"+str(type_res.tag_dict.size())
		while type_res.tag_dict.has(id):
			id=id+char(randi_range(97, 122))
	if type_res.tag_dict.has(id):
		return null
	else:
		type_res.tag_dict[id]=EB_Tag.new()
		return id


func save_to_file(path:String):
	if path == "":
		push_error("Cannot save: path is empty")
		return false
	var error = ResourceSaver.save(res, path)
	if error == OK:
		print("TagSet 保存成功: %s" % path)
		return true
	else:
		push_error("保存失败，错误码: %d" % error)
		return false
