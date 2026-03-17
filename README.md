# EasyBag
## 简介
  EasyBag是一款Godot中的库存与物品系统框架，通过可视化编辑器实现无代码编辑和自动生成物品
配置类，随后在gds代码中使用EasyBag系列的类进行玩法开发，可轻松实现设计师与工程师的巧妙合作。

## 快速开始
### 在可视化编辑器中创建物品
  #### 创建Codex(物品目录)
  1.先将下载取得EasyBag文件夹，将文件夹放置于res://addons/之下。<br>
  2.运行EasyBag文件夹下的EasyBag场景启动EB编辑器(不同于常见的Godot编辑器插件,由于EB编辑器需要占用大量资源所有需要作为场景运行而不是常驻在Godot编辑器面板中)<br>
  3.进入编辑器后点击上方工具栏的 file-new 打开创建文件面板<br>
  4.选择Codex并且选择好地址进行创建<br>
  5.在左边的编辑器中点击新增项即可添加物品<br>
  6.记得保存
  #### 为物品添加属性
  1.file-new打开创建面板<br>
  2.选择EB_AttributeSet并且选择好地址进行创建<br>
  3.左边的编辑器中点击新增项即可添加属性<br>
  4.选择一个属性<br>
  5.可在中间的编辑面板中更改属性类型，如改成Int类型<br>
  6.记得保存<br>
  7.关闭整个EasyBag编辑器(避免引用错误的资源，未来将解决此问题)<br>
  8.重新启动EasyBag编辑器并且打开codex<br>
  9.点击右上方的attribute选择属性集进行连接<br>
  10.选择一个物品，在中间的编辑面板即可为其添加属性<br>
  11.记得保存<br>
### 在代码中使用
  #### 创建Codex实例
  var codex:EB_Codex=preload("res://addons/easy_bag/workfile/Codex/你的资源")
  #### 创建容器实例
  var bag:EB_Inventory
  bag=ResourceLoader.load("user://bag.tres")
	if bag==null:
		bag=EB_Inventory.new()
  #推荐写在ready方法中
  #### 容器实例连接Codex实例
  bag.link_codex(codex)
  #### 生成新的物品
  var item=get_attribute_value(codexConfig.苹果.堆叠)
  #通常在EasyBag编辑器保存Codex后会在codex资源同路径下自动生成配置类
  var item2=codex.get_instantiate_InventoryItem_by_name("垃圾桶")
  var item3=codex.get_instantiate_InventoryItem_by_id("1")
  #### 为容器实例添加物品
  bag.add_item(item)
  #### 获取物品的属性
  for i in bag.get_all_items():
		var stack=i.get_attribute_value(codexConfig.苹果.堆叠)
		var stack_max=i.get_attribute_value(codexConfig.苹果.堆叠上限)
  
