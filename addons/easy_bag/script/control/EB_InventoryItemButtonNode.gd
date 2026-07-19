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
var durability_ProgressBar=ProgressBar.new()

func _on_item_change() -> void:
	refresh()

func _ready() -> void:
	custom_minimum_size = Vector2(50, 50)
	expand_icon = true
	
	# ===== 配置堆叠数字标签 =====
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
	
	# ===== 配置耐久度进度条 =====
	durability_ProgressBar.anchor_left = 0.0
	durability_ProgressBar.anchor_top = 1.0
	durability_ProgressBar.anchor_right = 1.0
	durability_ProgressBar.anchor_bottom = 1.0
	
	durability_ProgressBar.offset_left = 2
	durability_ProgressBar.offset_top = -8
	durability_ProgressBar.offset_right = -2
	durability_ProgressBar.offset_bottom = -2
	
	durability_ProgressBar.max_value = 100
	durability_ProgressBar.min_value = 0
	durability_ProgressBar.value = 100
	durability_ProgressBar.show_percentage = false
	
	# 进度条样式
	durability_ProgressBar.add_theme_color_override("fill_color", Color.GREEN)
	durability_ProgressBar.add_theme_color_override("background_color", Color(0.2, 0.2, 0.2, 0.8))
	durability_ProgressBar.add_theme_stylebox_override("fill", StyleBoxFlat.new())
	
	add_child(durability_ProgressBar)
	
	refresh()

func refresh() -> void:
	if item == null:
		icon = null
		tooltip_text = ""
		stack_lab.visible = false
		durability_ProgressBar.visible = false
		return
	
	if item.icon != null:
		icon = item.icon
	else:
		icon = null
	
	# 堆叠数字
	if "stack" in item and item.stack > 1:
		stack_lab.text = str(item.stack)
		stack_lab.visible = true
	else:
		stack_lab.visible = false
	
	# 耐久度显示
	if "durability" in item:
		var durability = item.durability
		var max_durability = item.max_durability if "max_durability" in item else 100
		durability_ProgressBar.max_value = max_durability
		durability_ProgressBar.value = durability
		durability_ProgressBar.visible = true
		
		# 根据耐久度改变颜色
		var percent = durability / float(max_durability)
		if percent > 0.5:
			durability_ProgressBar.add_theme_color_override("fill_color", Color.GREEN)
		elif percent > 0.25:
			durability_ProgressBar.add_theme_color_override("fill_color", Color.YELLOW)
		else:
			durability_ProgressBar.add_theme_color_override("fill_color", Color.RED)
	else:
		durability_ProgressBar.visible = false
	
	tooltip_text = item.item_name
