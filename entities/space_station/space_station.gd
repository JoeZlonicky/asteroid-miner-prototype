extends StaticBody2D


func _on_interactable_area_interacted_with() -> void:
	var scene_to_change_to: PackedScene = load("res://levels/space_station/space_station.tscn")
	get_tree().change_scene_to_packed(scene_to_change_to)
