extends CharacterBody2D


func _on_interactable_area_interacted_with() -> void:
	var game: Game = null
	game.change_location(load("res://content/locations/space_station/space_station.tres"))
