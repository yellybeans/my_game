extends CenterContainer

var inventory = preload("res://UI/Inventory.tres")
var stats = PlayerStats

onready var itemTextureRect = $ItemTextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Items/EmptyInventorySlot.png")

func get_stats_from_item(item):
	if item is Item :
		get_bonuses_from_item(item)
		
func get_bonuses_from_item(item):
	if item is Item:
		if item.name == "Shield":
			stats.max_health += item.health_bonus
			stats.health += item.health_bonus
			
func remove_bonuses_from_item(item):
	if item is Item:
		if item.name == "Shield":
			stats.health -= item.health_bonus
			stats.max_health -= item.health_bonus

func get_drag_data(_position):
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
		
		
		
func can_drop_data(_position, data): # for swapping items, picking up item
	print("asdasd")
	return data is Dictionary and data.has("item")

func drop_data(_position, data): # swapping items
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_item(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
	inventory.drag_data = null
	

