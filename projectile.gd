extends Area2D


const SPEED: float = 400.0

var velocity: Vector2


func fire(direction: Vector2, bonus_speed: float = 0.0) -> void:
	velocity = direction * (SPEED + bonus_speed)


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_lifespan_timeout() -> void:
	queue_free()
