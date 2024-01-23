extends CharacterBody2D


func _on_interactable_area_interacted_with() -> void:
	var game: Game = Utility.get_game(self)
	game.change_location(load("res://content/locations/space_station/space_station.tres"))
