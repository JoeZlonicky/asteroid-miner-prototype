class_name DockedPlayerShip
extends CharacterBody2D

signal interacted_with


func _on_right_interactable_area_interacted_with() -> void:
	interacted_with.emit()


func _on_left_interactable_area_interacted_with() -> void:
	interacted_with.emit()
