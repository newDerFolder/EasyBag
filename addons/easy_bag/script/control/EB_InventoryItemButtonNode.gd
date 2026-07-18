class_name EB_InventoryItemButtonNode extends Button

var item: EB_InventoryItem:
	set(value):
		if item and item.is_connected("item_change", _on_item_change):
			item.item_change.disconnect(_on_item_change)
		item = value
		if item:
			item.item_change.connect(_on_item_change)
		refresh()

var stack_lab = Label.new()

func _on_item_change() -> void:
	refresh()

func _ready() -> void:
	custom_minimum_size = Vector2(50, 50)
	expand_icon = true
	
	# 配置堆叠数字标签
	stack_lab.anchor_left = 1.0
	stack_lab.anchor_top = 1.0
	stack_lab.anchor_right = 1.0
	stack_lab.anchor_bottom = 1.0
	stack_lab.offset_left = -30
	stack_lab.offset_top = -25

	stack_lab.add_theme_font_size_override("font_size", 20)
	stack_lab.add_theme_color_override("font_color", Color.WHITE)
	stack_lab.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	stack_lab.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	stack_lab.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	
	add_child(stack_lab)
	refresh()

func refresh() -> void:
	if item == null:
		icon = null
		tooltip_text = ""
		stack_lab.visible = false
		return
	
	if item.icon != null:
		icon = item.icon
	else:
		icon = null
	
	if "stack" in item and item.stack > 1:
		stack_lab.text = str(item.stack)
		stack_lab.visible = true
	else:
		stack_lab.visible = false
	
	tooltip_text = item.item_name
