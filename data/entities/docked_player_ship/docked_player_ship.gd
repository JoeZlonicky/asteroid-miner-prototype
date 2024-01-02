class_name DockedPlayerShip
extends Entity

signal interacted_with


func _on_right_interact_area_interacted() -> void:
	interacted_with.emit()


func _on_left_interact_area_interacted() -> void:
	interacted_with.emit()
