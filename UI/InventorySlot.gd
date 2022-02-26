extends CenterContainer

var inventory = preload("res://UI/Inventory.tres")
var stats = PlayerStats

onready var itemTextureRect = $ItemTextureRect

# display item
func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Assets/Items/EmptyInventorySlot.png")

#add/remove item from slot
func add_item(item):
	print("adding item into slot")
	display_item(item)
	get_bonuses_from_item(item)
	#inventory.set_item(my_item_index, data.item)
	
func get_bonuses_from_item(item):
	if item is Item :
		stats.max_health += item.health_bonus
		stats.health += item.health_bonus

func drop_item(item):
	remove_bonuses_for_item(item)

func remove_bonuses_for_item(item):
	if item is Item :
		stats.health -= item.health_bonus
		stats.max_health -= item.health_bonus

## moving items
func get_drag_data(_position): # pick up item from slot
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		inventory.drag_data = data
		return data
		
func can_drop_data(_position, data): # hold item above inventory slot
	return data is Dictionary and data.has("item")

func drop_data(_position, data): # drop item into inventory slot
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_item(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
	inventory.drag_data = null
	

