class_name PlayerShip
extends CharacterBody2D


@onready var thrusters: TankMovementController = $Thrusters
@onready var left_trail: GPUParticles2D = $Thrusters/LeftTrail
@onready var right_trail: GPUParticles2D = $Thrusters/RightTrail
@onready var vehicle_seat: VehicleSeat = $VehicleSeat


func _physics_process(_delta: float) -> void:
	var has_forward_thrust: bool = thrusters.forward_input > 0.0
	left_trail.emitting = has_forward_thrust or thrusters.rotate_input > 0.0
	right_trail.emitting = has_forward_thrust or thrusters.rotate_input < 0.0


func _on_pickup_vacuum_node_reached_center(pickup: Pickup) -> void:
	var item_data: ItemData = pickup.item_data
	var player: Player = vehicle_seat.get_driver() as Player
	if player.inventory.add_item(item_data):
		pickup.queue_free()


func _on_vehicle_seat_new_driver_entered(_new_driver: CharacterBody2D) -> void:
	var game: Game = Utility.get_game(self)
	if not game:
		return
	
	game.vehicle_hud.set_vehicle(self)


func _on_vehicle_seat_driver_evicted(_evicted_driver: CharacterBody2D) -> void:
	var game: Game = Utility.get_game(self)
	if not game:
		return
	
	game.vehicle_hud.set_vehicle(null)
