@icon("res://addons/easy_bag/asset/icon/ballTwo.png")
@abstract class_name EB_BaseAttribute extends EasyBagResource


@export var attribute_name:String="a new attribute"
@export_multiline() var item_description:String=""

@abstract func get_value()
