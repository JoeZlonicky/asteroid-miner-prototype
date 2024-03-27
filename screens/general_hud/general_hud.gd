class_name GeneralHUD
extends CanvasLayer


@onready var notification_container: NotificationContainer = %NotificationContainer
@onready var inventory_panel: InventoryPanel = $InventoryPanel


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory"):
		inventory_panel.inventory = Session.player_inventory
		inventory_panel.visible = not inventory_panel.visible
