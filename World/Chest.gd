extends Area2D

var inventory = preload("res://UI/Inventory.tres")
onready var playerDetectionZone = $PlayerDetectionZone

func _on_Chest_body_entered(body):
	var player = playerDetectionZone.player
	if body == player:
		print("Juhuu")
		inventory.add_item("Shield")
		inventory.add_item("Sword")
		inventory.add_item("Ring")
		inventory.add_item("LongSword")
		queue_free()
