extends CanvasLayer

@onready var category_column = $Panel/HBoxContainer/CategoryColumn
@onready var item_column = $Panel/HBoxContainer/ItemColumn

func _ready():
	# Hide by default when the scene starts
	hide()

func _process(_delta):
	# Press "I" (or whatever action you map) to open/close inventory
	if Input.is_action_just_pressed("inventory"): 
		if not visible:
			open_inventory()
		else:
			close_inventory()

func open_inventory():
	get_tree().paused = true
	show()
	display_inventory_data()

func close_inventory():
	get_tree().paused = false
	hide()

func display_inventory_data():
	# Clear out old text from last time we opened it
	for child in category_column.get_children(): child.queue_free()
	for child in item_column.get_children(): child.queue_free()
	
	# Loop through our global backend and spawn labels
	for category in InventoryManager.current_inventory.keys():
		# 1. Add category to the left column
		var cat_label = Label.new()
		cat_label.text = category.to_upper()
		category_column.add_child(cat_label)
		
		# 2. Add all items belonging to that category to the right column
		for item in InventoryManager.current_inventory[category]:
			var item_label = Label.new()
			item_label.text = " - " + item
			item_column.add_child(item_label)
