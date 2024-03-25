class_name Pickup
extends CharacterBody2D

const DEFAULT_DRIFT_SPEED: float = 20.0

var item_data: ItemData = null

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	var random_angle: float = randf_range(0, 2 * PI)
	velocity = Vector2.from_angle(random_angle) * DEFAULT_DRIFT_SPEED


func _physics_process(_delta: float) -> void:
	move_and_slide()


func from_item_data(data: ItemData) -> void:
	item_data = data
	if not is_node_ready():
		await ready
	sprite.texture = data.sprite
