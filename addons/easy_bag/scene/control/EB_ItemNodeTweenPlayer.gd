class_name  EB_ItemNodeTweenPlayer

static func mouse_entered(node:Node):
	var tween=node.get_tree().create_tween()
	tween.tween_property(node,"scale",Vector2(1.2,1.2),0.2)
	tween.tween_property(node,"scale",Vector2(1,1),0.1)



static func mouse_pressed(node:Node):
	var tween=node.get_tree().create_tween()
	tween.tween_property(node,"scale",Vector2(0.6,0.6),0.2)
	tween.tween_property(node,"scale",Vector2(1,1),0.1)


static var selected_panel_StyleBoxFlat:StyleBoxFlat=null
static func get_selected_panel_StyleBoxFlat()->StyleBoxFlat:
	if selected_panel_StyleBoxFlat==null:
		selected_panel_StyleBoxFlat=StyleBoxFlat.new()
		selected_panel_StyleBoxFlat.bg_color = Color("#4a6a4a") # 选中的深绿色
		selected_panel_StyleBoxFlat.border_width_left = 4       # 增加一个明显的左边框
		selected_panel_StyleBoxFlat.border_color = Color("#ffffff") # 白色边框更醒目
	return selected_panel_StyleBoxFlat

static var unselected_panel_StyleBoxFlat:StyleBoxFlat=null
static func get_unselected_panel_StyleBoxFlat()->StyleBoxFlat:
	if unselected_panel_StyleBoxFlat==null:
		unselected_panel_StyleBoxFlat=StyleBoxFlat.new()
		unselected_panel_StyleBoxFlat.bg_color = Color("33333396") # 默认暗色
		unselected_panel_StyleBoxFlat.border_width_left = 0
	return unselected_panel_StyleBoxFlat


static func update_item_node_visuals(node:Node,is_selected:bool):
	var sb
	if is_selected:
		sb=EB_ItemNodeTweenPlayer.get_selected_panel_StyleBoxFlat()
	else:
		sb=EB_ItemNodeTweenPlayer.get_unselected_panel_StyleBoxFlat()
	node.add_theme_stylebox_override("panel", sb)
