@tool
@icon("res://easyBag/sc/easyBagIcon.png")
extends Node
class_name EasyBag




static func get_codexAttributeVal(codexItem:Dictionary,tagsDict:Dictionary,attributesDict:Dictionary)->Dictionary:
	var dict:Dictionary
	for i in codexItem["attributes"]:
		dict[i]=null
		if codexItem["attributesVal"][i]["extends"]==false:
			dict[i]=codexItem["attributesVal"][i]["val"]
		else:
			_get_attributeExtendsVal(codexItem,i,tagsDict,attributesDict)
	return dict
static func _get_attributeExtendsVal(codexItem,attribute,tagsDict:Dictionary,attributesDict:Dictionary):
	pass

static func get_tagInherentAttributes(tag:String,TagDict:Dictionary)->Array:
	var attributes_arr:Array
	for i in TagDict[tag]["inherentAttributes"]:
		attributes_arr.append(i)
	return attributes_arr

#子到根
static func get_extendsTagsArray(tag:Dictionary,tagsDict)->Array:
	var tagsArray:Array
	tagsArray.append(tag["name"])
	if tag["extends"].size()<1:
		return tagsArray
	for i in tag["extends"]:
		for a in get_extendsTagsArray(tagsDict[i],tagsDict):
			tagsArray.append(a)
	return tagsArray

static func get_newCodexItemDict()->Dictionary:
	return {"name":"new","iconPath":"","kind":"int","val":0,"static":true,"fromTag":"","description":"一个新属性"}
static func renameCodexItemAttributesData(codex:Dictionary, oldName: String, newName: String) -> void:
	for key: String in codex:
		var value = codex[key]["attributes"]
		var aVal=codex[key]["attributesVal"]
		# 确保 value 是数组
		if not value is Array:
			continue
		var array: Array = value
		var valDict:Dictionary=aVal
		# 遍历数组，替换 oldName
		for i in range(array.size()):
			if array[i] == oldName:
				valDict[newName]=valDict[oldName]
				valDict.erase(oldName)
				array[i] = newName

static func findItemByName(dict:Dictionary,find:String)->Array:
	var arr:Array=[]
	for i in dict:
		if i.begins_with(find):
			arr.append(i)
	return arr

#static func demo_tagsData()->Dictionary:
	#var dict={
		#"weapon":{"from":"","description":"this kind item always affect atk in RPG","linkAttribute":[]}
		#
	#}
	#return dict
#static func demo_attributeData()->Dictionary:
	#var dict={
		#"maxStack":{"value":99,"icon":"","description":"",},
		#"atk":{"value":5,"icon":"","description":"",},
		#"def":{"value":5,"icon":"","description":"",}
	#}
	#return dict

static func codexItem(itemName="noName")->Dictionary:
	var good={
		"iconPath":"res://easyBag/sc/apple.png",
		"name":itemName,
		"description":"",
		"tags":[],
		"attributes":[],
		"attributesVal":{}
		}
	return good
static func createCodex()->Dictionary:
	var basicDict={
		#"itemId-A":codexItem(),
		#"itemId-B":codexItem(),
		#"itemId-C":codexItem()
	}
	return basicDict
static func item()->Dictionary:
	var good={
		"id":"itemId-A",
		"stack":1,
		"special":{}
		}
	return good
#static func dropItem()->Dictionary:
	#var good=item()
	#good["dropWeight"]=1
	#good["isOneDrop"]=false
	#return good
#static func createDropPool()->Dictionary:
	#var basicDict={
		#"itemId-A":dropItem(),
		#"itemId-B":dropItem(),
		#"itemId-C":dropItem()
	#}
	#return basicDict
#static func createBag()->Array:
	#var bag=[item(),item(),item()]
	#return bag

static func saveFile(kind:String,saveData:Dictionary,path:String):
	print(path)
	path=path+".json"
	var data = {"kind":kind,"data":saveData}
	var json = JSON.new()
	var json_string = json.stringify(data)# 将字典序列化为 JSON 字符串
	var file = FileAccess.open(path, FileAccess.WRITE)  # 打开文件以写入
	file.store_line(json_string)  # 写入 JSON 数据
	file.close()  # 关闭文件
	print("easyBag file saved to: ", path)

static func loadFile(path):
	if not FileAccess.file_exists(path):
		print("easyBag file not found.")
		return
	var file = FileAccess.open(path, FileAccess.READ)  # 打开文件以读取
	var json_string = file.get_as_text()  # 读取 JSON 数据
	file.close()  # 关闭文件
	
	var json = JSON.new()
	var error = json.parse(json_string)  # 解析 JSON 数据
	if error != OK:
		print("easyBag:Failed to parse JSON: ", error)
		return
	var data = json.get_data()
	var dict:Dictionary
	if data.has("data"):
		dict["data"]= data["data"]
		dict["kind"]=data["kind"]
		dict["path"]=path
	return dict

static func loadEasybagData():
	var path="res://easyBag/data/easybag.json"
	if not FileAccess.file_exists(path):
		print("easyBag file not found.")
		return null
	var file = FileAccess.open(path, FileAccess.READ)  # 打开文件以读取
	var json_string = file.get_as_text()  # 读取 JSON 数据
	file.close()  # 关闭文件
	
	var json = JSON.new()
	var error = json.parse(json_string)  # 解析 JSON 数据
	if error != OK:
		print("easyBag:Failed to parse JSON: ", error)
		return null
	var data = json.get_data()
	var dict:Dictionary=data
	return dict
static func saveEasybagData(saveData:Dictionary):
	var path="res://easyBag/data/easybag.json"
	var data = saveData
	var json = JSON.new()
	var json_string = json.stringify(data)# 将字典序列化为 JSON 字符串
	var file = FileAccess.open(path, FileAccess.WRITE)  # 打开文件以写入
	print(json_string)
	file.store_line(json_string)  # 写入 JSON 数据
	file.close()  # 关闭文件
	print("easyBag file saved to: ", path)
