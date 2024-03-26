extends CharacterBody2D


var scene_to_change_to: PackedScene = load("res://levels/space/space.tscn")


func _on_interactable_area_interacted_with() -> void:
	get_tree().change_scene_to_packed(scene_to_change_to)
