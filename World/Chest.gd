extends Area2D

var inventory = preload("res://UI/Inventory.tres")
onready var playerDetectionZone = $PlayerDetectionZone

export var items : PoolStringArray = []

func _on_Chest_body_entered(body):
	var player = playerDetectionZone.player
	if body == player:
		print("Juhuu")
		for item in items:
			inventory.add_item(item)
		queue_free()
