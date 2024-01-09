class_name PlayerShip
extends Entity


@onready var inventory: Inventory = $Inventory
@onready var vehicle_component: VehicleComponent = $VehicleComponent


func _on_pickup_vacuum_item_pickup(item: ItemData) -> void:
	var player: Player = vehicle_component.driver as Player
	player.inventory.add_item(item)


func _on_inventory_item_added(item_data: ItemData, n: int) -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.general_hud.item_pickup_notification_container.display_notification(item_data, n)
