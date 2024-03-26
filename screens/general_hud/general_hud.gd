class_name GeneralHUD
extends CanvasLayer


@onready var item_pickup_notification_container: ItemPickupNoficationContainer = %ItemPickupNotificationContainer

@onready var inventory_panel: InventoryPanel = $InventoryPanel


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		var game: Game = get_parent() as Game
		var player: Player = game.player as Player
		inventory_panel.inventory = player.inventory
		inventory_panel.visible = not inventory_panel.visible
