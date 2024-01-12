extends Location


func _on_docked_player_ship_interacted_with() -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.change_location(load("res://content/locations/space/space.tres"))
