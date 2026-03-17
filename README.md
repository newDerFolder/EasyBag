# EasyBag(EN)
## Introduction
  EasyBag is an inventory and item system framework for Godot. It enables code-free editing and automatic generation of item configuration classes through a visual editor. Subsequently, developers can use the EasyBag series of classes in GDScript for gameplay development, facilitating seamless collaboration between designers and engineers.

## Quick Start
### Creating Items in the Visual Editor
  #### Creating a Codex (Item Directory)
  1.First, download the EasyBag folder and place it under res://addons/.<br>
  2.Run the EasyBag scene located in the EasyBag folder to launch the EB Editor. (Unlike common Godot editor plugins, the EB Editor requires significant resources and must be run as a scene rather than residing permanently in the Godot editor panel).<br>
  3.After entering the editor, click File > New in the top toolbar to open the file creation panel.<br>
  4.Select Codex, choose a destination, and create the file.<br>
  5.In the editor on the left, click Add Item to add items.<br>
  6.Remember to save.
  #### Adding Attributes to Items
  1.Click File > New to open the creation panel.<br>
  2.Select EB_AttributeSet, choose a destination, and create the file.<br>
  3.In the editor on the left, click Add Item to add attributes.<br>
  4.Select an attribute.<br>
  5.In the middle editing panel, you can change the attribute type, for example, to Int.<br>
  6.Remember to save.<br>
  7.Close the entire EasyBag Editor (to avoid referencing incorrect resources; this issue will be resolved in the future).<br>
  8.Restart the EasyBag Editor and open the Codex.<br>
  9.Click Attribute in the top right corner to select and connect an Attribute Set.<br>
  10.Select an item; you can now add attributes to it in the middle editing panel.<br>
  11.Remember to save.<br>
### Using in Code
  #### Creating a Codex Instance
  ```var codex: EB_Codex = preload("res://addons/easy_bag/workfile/Codex/YourResource")```
  #### Creating a Container Instance    
  ```
  var bag:EB_Inventory      
  bag=ResourceLoader.load("user://bag.tres")     
	if bag==null:   
		bag=EB_Inventory.new()   
  #Recommended to place in the ready method
```
  #### Linking the Container Instance to the Codex Instance
  ```bag.link_codex(codex)```
  #### Generating New Items
  ```
  #Usually, after saving the Codex in the EasyBag Editor, a configuration class is automatically generated   
  #in the same path as the codex resource.  
  var item = get_attribute_value(codexConfig.Apple.Stack)   
  var item2 = codex.get_instantiate_InventoryItem_by_name("TrashCan")    
  var item3 = codex.get_instantiate_InventoryItem_by_id("1")
```
  #### Adding Items to the Container Instance
  ```bag.add_item(item)```
  #### Getting Item Attributes
  ```
  for i in bag.get_all_items():     
    var stack = i.get_attribute_value(codexConfig.Apple.Stack)   
    var stack_max = i.get_attribute_value(codexConfig.Apple.StackLimit)
```






# EasyBag(CN)
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
  ```var codex:EB_Codex=preload("res://addons/easy_bag/workfile/Codex/你的资源")```
  #### 创建容器实例   
  ```
  var bag:EB_Inventory   
  bag=ResourceLoader.load("user://bag.tres")   
	if bag==null:   
		bag=EB_Inventory.new()
```
  #推荐写在ready方法中
  #### 容器实例连接Codex实例
  ```bag.link_codex(codex)```
  #### 生成新的物品
  ```var item=get_attribute_value(codexConfig.苹果.堆叠)```
  #通常在EasyBag编辑器保存Codex后会在codex资源同路径下自动生成配置类   
  ```
  var item2=codex.get_instantiate_InventoryItem_by_name("垃圾桶")   
  var item3=codex.get_instantiate_InventoryItem_by_id("1")
```
  #### 为容器实例添加物品
 ```bag.add_item(item)```   
  #### 获取物品的属性
  ```
  for i in bag.get_all_items():   
		var stack=i.get_attribute_value(codexConfig.苹果.堆叠)   
		var stack_max=i.get_attribute_value(codexConfig.苹果.堆叠上限)
```
  
