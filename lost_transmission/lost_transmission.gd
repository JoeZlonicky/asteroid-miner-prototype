extends Area2D


signal picked_up

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var picked_up_animation_player: AnimationPlayer = $PickedUpAnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	var player: Player = body as Player
	if player == null:
		return
	
	collision_shape.set_deferred("disabled", true)
	picked_up.emit()
	picked_up_animation_player.play("fade")


func _on_picked_up_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
