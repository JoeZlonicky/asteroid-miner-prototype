class_name Asteroid
extends StaticBody2D


const MAX_HEALTH: int = 5

var current_health: int = MAX_HEALTH

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_spawner: PickupSpawnerComponent = $PickupSpawnerComponent


func take_damage(amount: int = 1) -> void:
	current_health = max(current_health - amount, 0)
	if current_health == 0:
		pickup_spawner.spawn_pickups()
		queue_free()
	else:
		animation_player.play("flash")
