extends Entity


func _on_interact_area_interacted() -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.change_location(load("res://data/locations/space_station/space_station.tscn"))
