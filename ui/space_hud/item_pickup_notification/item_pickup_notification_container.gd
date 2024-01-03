class_name ItemPickupNoficationContainer
extends VBoxContainer


const PICKUP_NOTIFICATION_SCENE: PackedScene = preload("res://ui/space_hud/item_pickup_notification/item_pickup_notification.tscn")

var notifications: Dictionary = {}  # ItemData : notification


func display_notification(item_data: ItemData, n: int = 1) -> void:
	var notif: ItemPickupNotification = notifications.get(item_data, null)
	if notif == null:
		notif = PICKUP_NOTIFICATION_SCENE.instantiate()
		add_child(notif)
		
		notif.display(item_data, n)
		notifications[item_data] = notif
		
		notif.tree_exited.connect(_on_notification_tree_exited.bind(item_data))
	else:
		notif.add_to_displayed(n)


func _on_notification_tree_exited(item_data: ItemData) -> void:
	notifications.erase(item_data)
