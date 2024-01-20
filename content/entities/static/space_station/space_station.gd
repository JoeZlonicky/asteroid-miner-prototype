extends CharacterBody2D


func _on_interactable_component_interacted_with() -> void:
	var game: Game = get_tree().root.get_child(0) as Game
	assert(game != null)
	
	game.change_location(load("res://content/locations/space_station/space_station.tres"))
