class_name PlayerShip
extends CharacterBody2D


@onready var vehicle_component: VehicleComponent = $VehicleComponent
@onready var left_trail: GPUParticles2D = $Thrusters/LeftTrail
@onready var right_trail: GPUParticles2D = $Thrusters/RightTrail


func _on_pickup_vacuum_node_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	var player: Player = vehicle_component.driver as Player
	if player.inventory.add_item(item_data):
		pickup.queue_free()


func _on_thrusters_forward_input_received():
	left_trail.emitting = true
