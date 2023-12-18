class_name Asteroid
extends AnimatableBody2D

const MAX_HEALTH: int = 10

var current_health: int = MAX_HEALTH

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func take_damage(amount: int = 1):
	current_health = max(current_health - amount, 0)
	if current_health == 0:
		queue_free()
	else:
		animation_player.play("flash")
