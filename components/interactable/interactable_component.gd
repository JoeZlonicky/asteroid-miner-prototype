class_name InteractableComponent
extends Area2D


signal interacted_with

var is_player_inside: bool = false

@onready var label: Label = $Label


func _ready() -> void:
	label.visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_inside:
		interacted_with.emit()


func _on_body_entered(_body: Node2D) -> void:
	is_player_inside = true
	label.visible = true


func _on_body_exited(_body: Node2D) -> void:
	is_player_inside = false
	label.visible = false
