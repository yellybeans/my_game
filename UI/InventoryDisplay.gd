extends GridContainer

var inventory = preload("res://UI/Inventory.tres")
var stats = PlayerStats

func _ready():
	inventory.connect("items_changed",self, "_on_items_changed")
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
		update_inventory_slot_stat(item_index)

func update_inventory_slot_display(item_index):
	var inventorySlot = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlot.display_item(item)

func update_inventory_slot_stat(item_index):
	var inventorySlot = get_child(item_index)
	var item = inventory.items[item_index]
	print("update item get")
	inventorySlot.get_stats_from_item(item)

func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)
		#update_inventory_slot_stat(item_index)
