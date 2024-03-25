extends Node2D


func _on_docked_player_ship_interacted_with() -> void:
	get_tree().change_scene_to_file("res://scenes/space/space.tscn")
