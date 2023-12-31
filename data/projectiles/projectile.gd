class_name Projectile
extends Area2D


const SPEED: float = 800.0

var velocity: Vector2

@onready var explosion_animator: AnimationPlayer = $Explosion/AnimationPlayer


func fire(g_position: Vector2, angle: float, bonus_speed: float = 0.0) -> void:
	global_position = g_position
	rotation = angle
	velocity = Vector2(cos(angle), sin(angle)) * (SPEED + bonus_speed)


func _physics_process(delta: float) -> void:
	position += velocity * delta


func _on_lifespan_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	set_physics_process(false)
	explosion_animator.play("explode")
	if body is Asteroid:
		body.take_damage()
