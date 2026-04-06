extends EB_BaseEditor
class_name EB_AttributeSetEditor


func _init() -> void:
	res as EB_AttributeSet

func get_instantiate_item_attribute(item_res: EB_BaseAttribute,codex:EB_Codex) -> EB_ItemBaseAttribute:
	var new_ins: EB_ItemBaseAttribute
	
	if item_res is EB_IntAttribute:
		new_ins = EB_ItemIntAttribute.new()
		new_ins.value=item_res.default_value
	else:
		new_ins = EB_ItemBaseAttribute.new()
			
	var id = res.attribute_dict.find_key(item_res)
	if id != null:
		new_ins.attribute_id = id
		new_ins.is_static_attribute=item_res.default_static
		#new_ins.from_codex=codex
		
	return new_ins


func add_new_item(id=null):
	if id==null:
		id=str(res.attribute_dict.size())
		while res.attribute_dict.has(id):
			id=id+"_"+char(randi_range(97, 122))
	if res.attribute_dict.has(id):
		return null
	else:
		res.attribute_dict[id]=EB_BaseAttribute.new()
		return id


func save_to_file(path:String):
	if path == "":
		push_error("Cannot save: path is empty")
		return false
	# 创建新的资源实例并复制数据
	var error = ResourceSaver.save(res, path)
	if error == OK:
		# 只有在保存路径与当前资源路径不同时，才需要手动更新一下
		# self.take_over_path(path) 
		print("AttributeSet 保存成功: %s" % path)
		return true
	else:
		push_error("保存失败，错误码: %d" % error)
		return false
