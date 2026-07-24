@icon("res://addons/easy_bag/asset/icon/TagIcon.png")
class_name EB_BaseTag extends EasyBagResource
## 带有名称的标签，用于挂载到物品资源上。
## A named tag component intended to be attached to inventory items.
##
## 尽管当前除名称外暂无其他属性，但它是整个背包系统筛选与分类的核心机制。
## Despite currently exposing only a name, tags serve as the foundational 
## mechanism for filtering, querying, and categorizing items across EasyBag.
##
## @experimental


## @experimental
@export var tag_name: String = "new tag"
## 标签的显示名称 / Display name of the tag.

@export_multiline var tag_description: String = "no tag des"
## 标签描述（暂未启用）/ Tag description (reserved for future use).
