extends EB_BaseEditor
class_name EB_TagSetEditor


# 1. 将 type_res 改为私有变量，并去掉默认类型约束
var _type_res: EB_TagSet = null
# 2. 定义一个 getter，实现“懒加载”
# 只要外部代码访问 type_res，就会自动触发这个检查
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

# 3. 彻底清空 _init，不要在这里做任何事！
func _init() -> void:
	pass

# 4. 清空 _set，不要拦截赋值，让 Godot 自己把 res 设置好
# 如果你需要刷新 UI，可以在这里调用，但不要修改 res
func _set(property: StringName, value: Variant) -> bool:
	if property == "res":
		# 只是让 Godot 正常赋值，不做任何复杂的逻辑
		# 真正的初始化会延迟到第一次访问 type_res 时发生
		return false 
	return false

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
