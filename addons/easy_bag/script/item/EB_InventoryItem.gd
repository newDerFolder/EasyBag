class_name EB_InventoryItem extends EB_BaseItem

## 库存容器中的物品,可拥有属性和标签

@export var icon:Texture2D
@export var item_name:String="new InventoryItem"
#@export var attribute_arr:Array[EB_BaseAttribute]
@export var tag_arr:Array[EB_BaseTag]

signal item_change()

func _init() -> void:
	for i in tag_arr.size():
		if tag_arr[i] == null:
			push_error("tag_arr[" + str(i) + "] is null")

func set_item_stack(value:int):
	pass

func get_item_max_stack() -> int:
	return 1

func get_item_stack() -> int:
	return 1




## @experimental
## 允许您通过重写这个方法为物品项添加额外标签,重写的标签会在获取标签方法中被检查
func add_extra_tags()->Array[EB_BaseTag]:
	return []

func clone_self()->EB_InventoryItem:
	return self.duplicate(true)

func clone_with_id(item_id: String="") -> EB_InventoryItem:
	var ins:=self.duplicate(true)
	if item_id!="":
		ins.item_name=item_id
	return ins



## 通过传入的字符串判断是否拥有此标签
func has_tag_by_name(target_name:String)->bool:
	for i in tag_arr:
		if i.tag_name==target_name:
			return true
	for i in add_extra_tags():
		if i.tag_name==target_name:
			return true
	return false
