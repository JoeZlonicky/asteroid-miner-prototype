class_name Entity
extends CharacterBody2D


func _on_interact_area_interacted() -> void:
	get_tree().change_scene_to_file("res://data/locations/space_station/space_station.tscn")
