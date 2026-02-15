extends Resource
class_name EB_Codex

@export var tag_set:EB_CodexTagSet
@export var attribute_set:EB_CodexAttributeSet
@export var item_dict:Dictionary[String,EB_CodexItem]

func _init(codex_tres_path:String="") -> void:
	if codex_tres_path=="":
		pass
	#else:
		#load_data_from_file(codex_tres_path)


func load_data_from_file(path: String) -> bool:
	if ResourceLoader.exists(path):
		var loaded_res: EB_Codex = ResourceLoader.load(path)
		if loaded_res:
			# 将加载资源的属性复制到当前实例
			self.tag_set = loaded_res.tag_set.duplicate(true)
			self.attribute_set = loaded_res.attribute_set.duplicate(true)
			self.item_dict = loaded_res.item_dict.duplicate(true)
			return true
	push_error("Failed to load codex data from: %s" % path)
	return false


func save_to_file(path: String) -> bool:
	if path == "":
		push_error("Cannot save: path is empty")
		return false
	
	# 创建新的资源实例并复制数据
	var save_res = EB_Codex.new()
	save_res.tag_set = self.tag_set.duplicate(true) if self.tag_set else null
	save_res.attribute_set = self.attribute_set.duplicate(true) if self.attribute_set else null
	save_res.item_dict = self.item_dict.duplicate(true)
	
	# 保存到文件
	var error = ResourceSaver.save(save_res, path)
	if error == OK:
		#self.current_file_path = path  # 更新当前路径
		print("Codex saved successfully to: %s" % path)
		return true
	else:
		push_error("Failed to save codex to: %s, error code: %d" % [path, error])
		return false
