extends Node2D


func _on_docked_player_ship_interacted_with() -> void:
	var game: Game = null
	game.change_location(load("res://content/locations/space/space.tres"))
