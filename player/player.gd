class_name Player
extends CharacterBody2D


@onready var blaster: Equipment = $Blaster
@onready var thrusters: Equipment = $Thrusters
@onready var pickup_vacuum: Equipment = $PickupVacuum
@onready var inventory: Equipment = $Inventory


func _physics_process(delta: float) -> void:
	thrusters.active_update(delta)
	blaster.active_update(delta)
	pickup_vacuum.active_update(delta)
