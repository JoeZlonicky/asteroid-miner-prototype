class_name PlayerShip
extends CharacterBody2D


@onready var vehicle_component: VehicleComponent = $VehicleComponent
@onready var tank_controller_component: TankControllerComponent = $TankControllerComponent
@onready var left_trail: GPUParticles2D = $TankControllerComponent/LeftTrail
@onready var right_trail: GPUParticles2D = $TankControllerComponent/RightTrail


func _physics_process(_delta: float) -> void:
	left_trail.emitting = tank_controller_component.forward_input or tank_controller_component.rotate_input > 0.0
	right_trail.emitting = tank_controller_component.forward_input or tank_controller_component.rotate_input < 0.0
	

func _on_pickup_vacuum_node_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	var player: Player = vehicle_component.driver as Player
	if player.inventory.add_item(item_data):
		pickup.queue_free()
