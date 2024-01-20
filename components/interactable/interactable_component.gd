@tool
class_name InteractableComponent
extends Area2D


signal interacted_with

@export var text: String = "Interact":
	set = set_text
@export var text_offset: Vector2:
	set = set_text_offset
@export var interact_radius: int = 200:
	set = set_interact_radius

var is_player_inside: bool = false

@onready var label: Label = $LabelOffset/Label
@onready var label_offset: Control = $LabelOffset
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	label.visible = Engine.is_editor_hint()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_inside:
		interacted_with.emit()


func set_text(new_text: String) -> void:
	text = new_text
	if not label:
		await ready
	label.text = text


func set_text_offset(new_offset: Vector2) -> void:
	if not label_offset:
		await ready
	text_offset = new_offset
	label_offset.position = text_offset


func set_interact_radius(new_radius: int) -> void:
	if not collision_shape:
		await ready
	interact_radius = new_radius
	collision_shape.shape.radius = interact_radius


func _on_body_entered(_body: Node2D) -> void:
	is_player_inside = true
	label.visible = true


func _on_body_exited(_body: Node2D) -> void:
	is_player_inside = false
	label.visible = false
