extends Resource
class_name EB_AttributeSet

@export var attribute_dict:Dictionary[String,EB_BaseAttribute]

#func add_new_item(id=null):
	#if id==null:
		#id=str(attribute_dict.size())
		#while attribute_dict.has(id):
			#id=id+"_"+char(randi_range(97, 122))
	#if attribute_dict.has(id):
		#return null
	#else:
		#attribute_dict[id]=EB_BaseAttribute.new()
		#return id

#func save_to_file(path:String):
	#if path == "":
		#push_error("Cannot save: path is empty")
		#return false
	## 创建新的资源实例并复制数据
	#var save_res = EB_AttributeSet.new()
	#save_res.attribute_dict = self.attribute_dict.duplicate(true) if self.attribute_dict else null
	## 保存到文件
	#var error = ResourceSaver.save(save_res, path)
