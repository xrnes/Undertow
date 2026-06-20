extends Node

# This dictionary holds our categories as lists of item names
var current_inventory = {
	"WEAPONS": ["Revolver"],
	"KEY ITEMS": ["Liquor Key"],
	"RESOURCES": ["Matches"]
}

# A simple helper function to check if we have an item
func has_item(category: String, item_name: String) -> bool:
	if category in current_inventory:
		return current_inventory[category].has(item_name)
	return false

# A function to add items later
func add_item(category: String, item_name: String):
	if category in current_inventory:
		current_inventory[category].append(item_name)
