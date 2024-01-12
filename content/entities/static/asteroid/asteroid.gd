class_name Asteroid
extends StaticBody2D

const ORE_DATA: ItemData = preload("uid://detpa4q3sm7m0")

const N_ORE_DROPPED = 5
const MAX_HEALTH: int = 5

var current_health: int = MAX_HEALTH

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func take_damage(amount: int = 1) -> void:
	current_health = max(current_health - amount, 0)
	if current_health == 0:
		for i in N_ORE_DROPPED:
			var ore: Pickup = ORE_DATA.create_pickup()
			get_parent().call_deferred("add_child", ore)
			ore.global_position = global_position
		
		queue_free()
	else:
		animation_player.play("flash")
