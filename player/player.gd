class_name Player
extends CharacterBody2D


@onready var blaster: Equipment = $Blaster
@onready var thrusters: Equipment = $Thrusters


func _physics_process(delta: float) -> void:
	thrusters.active_update(delta)
	blaster.active_update(delta)
