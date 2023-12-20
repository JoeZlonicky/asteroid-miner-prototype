class_name PickUp
extends Area2D

signal picked_up(player: Player)

const PASSIVE_DRIFT_SPEED: float = 20.0

var is_drifting: bool = true
var drift_velocity: Vector2


func _ready() -> void:
	var random_angle = randf_range(0, 2 * PI)
	drift_velocity = Vector2(cos(random_angle), sin(random_angle)) * PASSIVE_DRIFT_SPEED


func _physics_process(delta: float) -> void:
	if not is_drifting:
		return
	
	position += drift_velocity * delta


func _on_body_entered(body: Node2D) -> void:
	var player: Player = body as Player
	if player == null:
		return
	
	picked_up.emit(player)
	queue_free()
