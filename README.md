# EasyBag
## 简介
EasyBag是Godot中的一个库存系统插件，着力于高度解耦和数据化，和可扩展性，致力于加速和稳固中大型角色扮演游戏亦或者是需要高度定制化库存系统的项目。
配合Godot的资源类，使其可以在Godot编辑器面板中比较物品的属性或标签。实现程序员与策划人员的有序合作。
同时EasyBag也提供了些类快速实现如物品随机掉落，物品配方合成等功能。当然你也可以自己自由扩展。
## 快速入门

### 创建资源文件
1. EasyBag基于Godot的资源文件，以此请先创建一个```EB_InventoryItem```类型的资源文件
2. 双击你创建的资源文件，可以看到右侧的属性面板
3. 你最好保持文件名和```item_name```属性相同，这是个潜规则
4. ```attribute_arr```空无一物，是时候创建了，添加元素吧，来个``` EB_IntAttribute```属性
5. 点开这个属性，可以看到```value```,```attribute_name```，```is_static```
6. 试着更改更改属性名称为```atk```，将值改成```10```
7. 添加一个标签吧，你得先创建一个标签
8. 新建```EB_BaseTag```类型的资源文件，记得保存文件名称和```tag_name```属性一致
9. 重写点回你之前创建的```EB_InventoryItem```类型资源文件，为其```tag_arr```添加tag，点击快速加载选择刚刚创建的tag

### 加载物品到库存
创建一个场景并且编辑其脚本
在```_ready```函数中
```
#加载物品
var my_item:=load("res://resource/你的文件路径.tres")
#创建库存容器
var my_inventory:=EB_Inventory.new()
#将物品添加进去
my_inventory.add_item(my_item)
```
是的这样子my_inventory中就有这个物品了

### 更加集中式的做法
1. 创建一个```EB_DictionaryCodex```的资源文件
2. 为其添加键值对，注意值应该快速加载你创建过的物品项
3. 加载物品到库存
```
#你可以选择用键或者是物品名称获取物品
codex.get_InventoryItem_by_name("")
codex.get_InventoryItem_by_id("")
var new_item=codex.get_InventoryItem_by_id("你的键")
#将物品添加进去
inventory.add_item(new_item)
```

### 还有很多
当然这个快速入门比较短，EasyBag中还有许多基础用法和进阶用法，比如说掉落池或者是配方类，未来我们会进一步完善文档。


# EasyBag

## Introduction
EasyBag is an inventory system plugin for Godot, focusing on high decoupling, data-driven design, and scalability. It is dedicated to accelerating and stabilizing medium-to-large RPG projects or any project requiring a highly customizable inventory system.

By leveraging Godot's Resource system, it allows you to compare item attributes and tags directly within the Godot editor panel, facilitating an organized workflow between programmers and game designers.

EasyBag also provides utility classes to quickly implement features like random item drops and crafting recipes. Of course, you are free to extend it however you like.

## Quick Start

### Creating Resource Files
1. EasyBag is built on Godot's Resource system. Start by creating a resource file of type `EB_InventoryItem`.
2. Double-click your newly created resource file to view its properties in the right-side panel.
3. **Pro Tip:** It's highly recommended to keep the file name identical to the `item_name` property. This is a widely accepted convention.
4. The `attribute_arr` is currently empty—time to create one! Add an element, such as an `EB_IntAttribute`.
5. Click on this attribute to reveal its properties: `value`, `attribute_name`, and `is_static`.
6. Try changing the attribute name to `atk` and setting the value to `10`.
7. Next, let's add a tag. First, you need to create the tag itself.
8. Create a new resource file of type `EB_BaseTag`. Remember to save the file with a name that matches the `tag_name` property.
9. Go back to your `EB_InventoryItem` resource file, add the tag to its `tag_arr`, and use the Quick Load feature to select the tag you just created.

### Loading Items into Inventory
Create a scene and edit its script. In the `_ready` function:

```gdscript
# Load the item
var my_item := load("res://resource/your_file_path.tres")

# Create an inventory container
var my_inventory := EB_Inventory.new()

# Add the item to the inventory
my_inventory.add_item(my_item)
```

And just like that, your item is now in `my_inventory`!

### A More Centralized Approach
1. Create a resource file of type `EB_DictionaryCodex`.
2. Add key-value pairs to it. Note that the values should be Quick Loaded from the item resources you've previously created.
3. Load items into the inventory:

```gdscript
# You can retrieve items using either a key or an item name
codex.get_InventoryItem_by_name("")
codex.get_InventoryItem_by_id("")

var new_item = codex.get_InventoryItem_by_id("your_key")

# Add the item to the inventory
inventory.add_item(new_item)
```

### And There's More!
Of course, this quick start guide is quite brief. EasyBag includes many basic and advanced features, such as drop pools and crafting recipes. We will continue to improve and expand the documentation in the future.
