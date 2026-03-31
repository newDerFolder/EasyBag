extends EB_BaseEditor
class_name EB_CodexEditor


# 【新增】请在编辑器 Inspector 面板中将包含所有属性定义的 EB_AttributeSet 资源拖入此槽位
@export var attribute_set: EB_AttributeSet 


func _init() -> void:
	res as EB_Codex

func del_item_attribute(item_res: EB_CodexItem, attr: EB_ItemBaseAttribute) -> void:
	if item_res == null or attr == null:
		return

	# 1. 获取正确的 Key (必须是 String 类型的 attribute_id)
	var id_key = attr.attribute_id
	
	# 2. 检查字典是否存在该 Key (可选，防止报错，虽然 erase 不存在 key 也不会报错)
	if item_res.attribute_dict.has(id_key):
		# 3. 使用 String ID 进行删除，而不是使用对象本身
		item_res.attribute_dict.erase(id_key)
		
		# 4. 触发资源更新
		item_res.emit_changed()
		print("成功删除属性 ID: ", id_key)
	else:
		push_warning("尝试删除不存在的属性 ID: ", id_key)
	

func add_new_attribute_items(item_res: EB_CodexItem, arr: Array[EB_ItemBaseAttribute]) -> void:
	if item_res == null: return
	
	# 假设 item_res.attribute_dict 的类型是 Dictionary
	# 如果 Godot 版本支持强类型字典，可以写成: var typed_dict: Dictionary = ...
	# 但通常 Dictionary 不需要显式声明泛型，除非你定义了特定的类映射
	
	# 1. 拿到当前已有的字典副本 (深拷贝，避免直接修改原资源直到最后)
	# 注意：这里假设 attribute_dict 的 Key 是 attribute_id (int 或 String)，Value 是 EB_ItemBaseAttribute
	var typed_dict: Dictionary = item_res.attribute_dict.duplicate(true)
	
	var changed = false
	
	for attr in arr:
		if attr:
			# 2. 检查字典中是否已存在该 ID (作为 Key)
			# 假设 attr.attribute_id 是唯一标识符
			var id_key = attr.attribute_id
			
			if not typed_dict.has(id_key):
				# 使用 true 进行深拷贝，并清除路径，强制作为本地子资源存储
				var new_attr = attr.duplicate(true)
				new_attr.resource_path = "" 
				
				# 3. 存入字典，Key 为 ID，Value 为属性对象
				typed_dict[id_key] = new_attr
				
				changed = true
	
	if changed:
		# 4. 重新赋值触发 Resource 的更新逻辑
		item_res.attribute_dict = typed_dict
		item_res.emit_changed()

	
func get_attributes_SetId_arr(arr:Array[EB_ItemBaseAttribute])->Array[String]:
	var ret_arr:Array[String]=[]
	for i:EB_ItemBaseAttribute in arr:
		ret_arr.append(i.attribute_id)
	return ret_arr



##添加新物品项,若成功返回id,若失败返回null
func add_new_item(id=null):
	if id==null:
		id=str(res.item_dict.size())
		while res.item_dict.has(id):
			id=id+"_"+char(randi_range(97, 122))
	if res.item_dict.has(id):
		return null
	else:
		res.item_dict[id]=EB_CodexItem.new()
		return id

func save_to_file(path: String) -> EB_Codex: # 修改返回值类型
	res.take_over_path(path)
	ResourceSaver.save(res, path)
	# 返回加载后的新实例
	return ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_REPLACE)


func save_config_to_file(path: String) -> bool:
	if not res:
		push_error("EB_CodexEditor: 资源为空，无法生成配置")
		return false

	# 【调试】检查 attribute_set 是否已赋值
	if not attribute_set:
		push_warning("EB_CodexEditor: attribute_set 未赋值！生成的属性名将回退为 ID (如 A_0, A_1)。请在 Inspector 中拖入 EB_AttributeSet 资源。")
	else:
		print("EB_CodexEditor: 已加载 AttributeSet，包含属性数量: ", attribute_set.attribute_dict.size() if attribute_set.attribute_dict else 0)

	# 1. 确保路径以 .gd 结尾
	var script_path = path
	if script_path.ends_with(".tres") or script_path.ends_with(".res"):
		script_path = script_path.substr(0, script_path.length() - 5) + ".gd"
	elif not script_path.ends_with(".gd"):
		script_path += ".gd"
	
	# 2. 构建文件内容
	var lines: PackedStringArray = []
	
	lines.append("extends RefCounted")
	
	# 计算 class_name
	var file_name_only = script_path.get_file()
	var class_name_raw = file_name_only.get_basename()
	
	if class_name_raw.contains("."):
		class_name_raw = class_name_raw.split(".")[0]
		
	lines.append("class_name "+""+ class_name_raw+"Config")
	
	lines.append("")
	lines.append("# 自动生成的物品配置类 (基于 Dictionary, 值为 Attribute ID)")
	lines.append("# 源数据来自: " + path)
	lines.append("# 生成时间: " + Time.get_datetime_string_from_system())
	lines.append("")
	
	# 遍历字典生成类
	for item_id in res.item_dict.keys():
		var item: EB_CodexItem = res.item_dict[item_id]
		
		if not item:
			continue
			
		# 1. 处理物品类名
		var raw_class_name = item.item_name if item.item_name else str(item_id)
		var safe_class_name = _sanitize_identifier(raw_class_name)
		
		if safe_class_name.is_empty():
			safe_class_name = "Item_" + _sanitize_identifier(str(item_id))
			
		if not safe_class_name.is_empty() and safe_class_name[0] >= "0" and safe_class_name[0] <= "9":
			safe_class_name = "Item_" + safe_class_name
			
		var target_id = item_id
		
		# 2. 写入类定义和 ID
		lines.append("class {cname} extends EB_CodexConfigItem:".format({"cname": safe_class_name}))
		lines.append("\tconst codex_id=\"{id}\"".format({"id": target_id}))
		 
		# 3. 遍历属性
		if item.attribute_dict and not item.attribute_dict.is_empty():
			var sorted_keys = item.attribute_dict.keys()
			sorted_keys.sort_custom(func(a, b): return str(a) < str(b))
			
			for attr_id in sorted_keys:
				var attr_base: EB_ItemBaseAttribute = item.attribute_dict[attr_id]
				
				if not attr_base:
					continue
				
				# --- 确定常量名 (显示名称) ---
				var final_const_name = ""
				var debug_source = "ID" # 用于调试打印
				
				# 尝试从 AttributeSet 获取名称
				if attribute_set:
					# 安全检查：确保 attribute_dict 存在且包含该 key
					if attribute_set.attribute_dict and attribute_set.attribute_dict.has(attr_id):
						var specific_attr_def: EB_BaseAttribute = attribute_set.attribute_dict[attr_id]
						if specific_attr_def and not specific_attr_def.item_name.is_empty():
							final_const_name = specific_attr_def.item_name
							debug_source = "Set[" + str(attr_id) + "]"
					else:
						# 如果 AttributeSet 里没有这个 ID，打印警告
						pass # 静默失败，稍后统一打印或忽略
				else:
					# 如果没有 AttributeSet，尝试从 attr_base 自身找 (虽然你的类里没有，但以防万一)
					# 你的 EB_ItemBaseAttribute 没有 item_name 字段，所以这步通常跳过
					pass
				
				# 降级：如果没拿到具体名字，直接用 attribute_id
				if final_const_name.is_empty():
					final_const_name = str(attr_id)
					debug_source = "Fallback(ID)"
				
				# 安全化处理
				final_const_name = _sanitize_identifier(final_const_name)
				
				if final_const_name.is_empty():
					final_const_name = "Attr_" + str(sorted_keys.find(attr_id))
				
				# 【调试打印】如果最终名字还是像 A_0, A_2 这种，说明没读到中文名
				# 你可以在控制台看到是哪个属性没读到名字
				if final_const_name.begins_with("A_") or final_const_name == str(attr_id):
					print("注意: 属性 ID [", attr_id, "] 未找到对应名称，来源: ", debug_source, ". 检查 AttributeSet 是否包含此 ID 且 item_name 不为空。")
				
				# --- 确定常量值 ---
				var attr_value_str = ""
				if typeof(attr_id) == TYPE_STRING:
					attr_value_str = "\"{val}\"".format({"val": attr_id})
				else:
					attr_value_str = str(attr_id)
				
				lines.append("\tconst {name} = {value}".format({"name": final_const_name, "value": attr_value_str}))
		
		lines.append("") 
		
	var script_content = "\n".join(lines)
	
	# 3. 写入文件
	var file = FileAccess.open(script_path, FileAccess.WRITE)
	if file == null:
		push_error("无法创建文件: " + script_path + " 错误: " + str(FileAccess.get_open_error()))
		return false
	
	file.store_string(script_content)
	file.close()
	
	print("成功生成配置脚本: ", script_path)
	
	# 4. 刷新文件系统
	if Engine.is_editor_hint():
		var editor_fs = EditorInterface.get_resource_filesystem()
		if editor_fs:
			editor_fs.scan_sources()
	
	return true
# 辅助函数：清理标识符，使其符合 GDScript 变量命名规范 (全球语言通用版 - 修复版)
func _sanitize_identifier(raw: String) -> String:
	if raw.is_empty():
		return ""
	
	var result = ""
	
	for c in raw:
		var code = c.unicode_at(0)
		
		# 1. 显式允许下划线 (_)
		if code == 95: 
			result += c
			continue
			
		# 2. ASCII 字符处理 (英文字母 a-z, A-Z 和 数字 0-9)
		if code < 128:
			# A-Z (65-90), a-z (97-122), 0-9 (48-57)
			if (code >= 65 and code <= 90) or \
			   (code >= 97 and code <= 122) or \
			   (code >= 48 and code <= 57):
				result += c
			else:
				# 其他 ASCII 符号 (空格, 标点等) 转为下划线
				result += "_"
		else:
			
			if code == 160 or (code >= 8203 and code <= 8205):
				result += "_"
			else:
				# 直接保留：汉字、假名、谚文、西里尔字母等都在这一步被保留
				result += c

	# 后处理：如果结果以数字开头，GDScript 不允许，需添加前缀
	if not result.is_empty() and result[0] >= "0" and result[0] <= "9":
		result = "A_" + result
		
	# 极端情况：如果处理后全变成了下划线或为空 (例如输入全是 emoji 或标点)
	if result.is_empty() or result.replace("_", "").is_empty():
		# 返回一个基于原字符串哈希的唯一名称，防止冲突
		return "Attr_" + str(abs(raw.hash()))
		
	return result
