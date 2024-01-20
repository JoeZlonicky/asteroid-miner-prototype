class_name PlayerShip
extends CharacterBody2D


@onready var thrusters: TankControllerComponent = $Thrusters
@onready var left_trail: GPUParticles2D = $Thrusters/LeftTrail
@onready var right_trail: GPUParticles2D = $Thrusters/RightTrail
@onready var vehicle_component: VehicleComponent = $VehicleComponent


func _physics_process(_delta: float) -> void:
	var has_forward_thrust: bool = thrusters.forward_input > 0.0
	left_trail.emitting = has_forward_thrust or thrusters.rotate_input > 0.0
	right_trail.emitting = has_forward_thrust or thrusters.rotate_input < 0.0


func _on_pickup_vacuum_node_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	var player: Player = vehicle_component.driver as Player
	if player.inventory.add_item(item_data):
		pickup.queue_free()
