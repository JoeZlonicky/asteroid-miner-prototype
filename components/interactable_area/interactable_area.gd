class_name InteractableArea
extends Area2D


signal interacted_with

@export var _toggle_visibility: CanvasItem

var _is_player_inside: bool = false


func _ready() -> void:
	if _toggle_visibility != null:
		_toggle_visibility.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and _is_player_inside:
		interacted_with.emit()


func _on_body_entered(_body: Node2D) -> void:
	_is_player_inside = true
	if _toggle_visibility != null:
		_toggle_visibility.show()


func _on_body_exited(_body: Node2D) -> void:
	_is_player_inside = false
	if _toggle_visibility != null:
		_toggle_visibility.hide()
