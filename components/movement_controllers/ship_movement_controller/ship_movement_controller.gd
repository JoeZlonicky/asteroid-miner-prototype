class_name ShipMovementController
extends RefCounted


var foward_force: float = 300.0

var active_velocity_damp: float = 4.0
var passive_velocity_damp: float = 0.04
var damp_change_speed: float = 2.0

var rotation_force: float = 10000.0
var passive_rotation_damp: float = 0.05


func update(body: RigidBody2D, input: Vector2, delta: float) -> void:
	process_rotation(body, input, delta)
	process_velocity(body, input, delta)


func process_velocity(body: RigidBody2D, input: Vector2, delta: float) -> void:
	var forward_input: float = input.y
	if forward_input > 0.0:
		apply_active_foward_acceleration(body, delta)
		apply_passive_velocity_deceleration(body, delta)
	elif forward_input < 0.0:
		apply_active_velocity_deceleration(body, delta)
	else:
		apply_passive_velocity_deceleration(body, delta)


func process_rotation(body: RigidBody2D, input: Vector2, _delta: float) -> void:
	body.angular_damp = passive_rotation_damp
	var rotate_input: float = input.x
	if rotate_input:
		body.apply_torque(signf(rotate_input) * rotation_force)


func apply_active_foward_acceleration(body: RigidBody2D, _delta: float) -> void:
	var angle: float = body.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	body.apply_force(direction * foward_force)


func apply_active_velocity_deceleration(body: RigidBody2D, delta: float) -> void:
	body.linear_damp = move_toward(body.linear_damp, active_velocity_damp,
		damp_change_speed * delta)


func apply_passive_velocity_deceleration(body: RigidBody2D, delta: float) -> void:
	body.linear_damp = move_toward(body.linear_damp, passive_velocity_damp,
		damp_change_speed * delta)
