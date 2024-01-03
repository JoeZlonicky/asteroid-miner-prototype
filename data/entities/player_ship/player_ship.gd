class_name Player
extends Entity


@onready var inventory: Inventory = $Inventory


func _on_pickup_vacuum_item_pickup(item: ItemData) -> void:
	inventory.add_item(item)


func _on_inventory_item_added(item_data: ItemData, n: int) -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.hud.item_pickup_notification_container.display_notification(item_data, n)
