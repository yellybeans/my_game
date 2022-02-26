extends Node

var all_items = Array()

func _ready():
	var directory = Directory.new()
	directory.open("res://Items/items")
	directory.list_dir_begin()
	
	var filename = directory.get_next()
	while(filename):
		if not directory.current_is_dir():
			all_items.append(load("res://Items/items/%s" % filename))
		
		filename = directory.get_next()
		
func get_item(item_name):
	for item in all_items:
		if item.name == item_name:
			return item
	
	return null
	
	
