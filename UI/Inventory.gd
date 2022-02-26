extends Resource
class_name Inventory

var drag_data = null

signal items_changed(indexes)
signal item_added(index)

export(Array, Resource) var items = [
	null,null,null,null,null,null
]

func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed",[item_index])
	return previousItem

func swap_item(item_index, target_item_index):
	var targetItem = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = targetItem
	emit_signal("items_changed",[item_index,target_item_index])
	

func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed",[item_index])
	return previousItem

func add_item(item_name): 
	print("adding item")
	var item = ItemDatabase.get_item(item_name)
	if not item:
		print("Cant find Item name: %s" % item_name)
		return
	for i in items.size():
		if not items[i]:
			set_item(i, item)
			emit_signal("item_added",i)
			print("item slot set")
			return
	return
