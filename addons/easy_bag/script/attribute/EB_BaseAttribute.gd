## @experimental
@icon("res://addons/easy_bag/asset/icon/ballTwo.png")
@abstract class_name EB_BaseAttribute extends EasyBagResource




@export var attribute_name:String="a new attribute"
@export var is_static:bool=true
#enum Hand_Mode{
	#ExactMatch,#完全一致
	#CompareNumber,#大于等于即可
	#CheckAndConsumeNumber#大于等于并且减少
#}
#@export var hand_mode:Hand_Mode=Hand_Mode.ExactMatch
#@export_multiline() var item_description:String=""


@abstract func get_value()
@abstract func set_value(new_value)
@abstract func compare_value(new_value)->bool
func get_attribute_name()->String:
	return attribute_name
