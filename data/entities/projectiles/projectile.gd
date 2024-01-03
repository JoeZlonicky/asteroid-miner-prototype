class_name Projectile
extends Entity


const SPEED: float = 2400.0

@onready var explosion_animator: AnimationPlayer = $Explosion/AnimationPlayer


func fire(g_position: Vector2, angle: float, bonus_speed: float = 0.0) -> void:
	global_position = g_position
	rotation = angle
	velocity = Vector2(cos(angle), sin(angle)) * (SPEED + bonus_speed)


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_lifespan_timeout() -> void:
	queue_free()


func _on_hit_area_body_entered(body: Node2D) -> void:
	set_physics_process(false)
	explosion_animator.play("explode")
	if body is Asteroid:
		body.take_damage()
