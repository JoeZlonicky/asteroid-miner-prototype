extends PickUp


func _on_picked_up(player: Player) -> void:
	player.inventory.add_item("ore")
