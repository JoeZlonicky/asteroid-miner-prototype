class_name Player
extends Entity


@onready var inventory: Inventory = $Inventory


func _on_pickup_vacuum_item_pickup(item):
	inventory.add_item(item)
