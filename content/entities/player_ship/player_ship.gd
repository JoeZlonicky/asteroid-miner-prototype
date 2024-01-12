class_name PlayerShip
extends CharacterBody2D


@onready var inventory: InventoryComponent = $Inventory
@onready var vehicle_component: VehicleComponent = $VehicleComponent


func _on_pickup_vacuum_node_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	var player: Player = vehicle_component.driver as Player
	if player.inventory.add_item(item_data):
		pickup.queue_free()


func _on_inventory_item_added(item_data: ItemData, n: int) -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.general_hud.item_pickup_notification_container.display_notification(item_data, n)
