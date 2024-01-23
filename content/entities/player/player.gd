class_name Player
extends CharacterBody2D


@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var inventory: Inventory = $Inventory
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D


func _on_inventory_item_added(item_data: ItemData, n: int) -> void:
	var game: Game = Utility.get_game(self)
	game.general_hud.item_pickup_notification_container.display_notification(item_data, n)
