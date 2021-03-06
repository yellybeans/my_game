extends GridContainer

var inventory = preload("res://UI/Inventory.tres")
var stats = PlayerStats

onready var inventorySlots = $InventorySlot

func _ready():
	inventory.connect("items_changed",self, "_on_item_position_changed")
	inventory.connect("item_added",self, "_on_item_added_in_position")
	init_inventory()
	
func init_inventory():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)

#update visuals of item swap
func update_inventory_slot_display(item_index):
	var inventorySlot = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlot.display_item(item)

# items swapped
func _on_item_position_changed(indexes):
	print("item position changed")
	for item_index in indexes:
		update_inventory_slot_display(item_index)
