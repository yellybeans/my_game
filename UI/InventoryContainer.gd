extends ColorRect

var inventory = preload("res://UI/Inventory.tres")
var stats = PlayerStats
onready var inventorySlot = $CenterContainer/InventoryDisplay/InventorySlot


func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position, data):
	inventory.set_item(data.item_index, data.item)
	inventory.drag_data = null

func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if inventory.drag_data is Dictionary:
			inventorySlot.remove_bonuses_from_item(inventory.drag_data.item)
