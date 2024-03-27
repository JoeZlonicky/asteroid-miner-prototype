class_name DockedPlayerShip
extends CharacterBody2D


func exit_to_space() -> void:
	var scene_to_change_to: PackedScene = load("res://levels/space/space.tscn")
	get_tree().change_scene_to_packed(scene_to_change_to)

func _on_right_interactable_area_interacted_with() -> void:
	exit_to_space()


func _on_left_interactable_area_interacted_with() -> void:
	exit_to_space()
