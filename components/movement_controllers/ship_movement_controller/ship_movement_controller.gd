class_name ShipMovementController
extends RefCounted


var foward_acceleration: float = 320.0
var max_forward_speed: float = 700.0

var active_velocity_deceleration: float = 300.0
var passive_velocity_deceleration: float = 10.0

var rotation_acceleration: float = 1.5
var max_rotation_speed: float = 1.5
var passive_rotation_deceleration: float = 2.0

var current_rotation_speed: float = 0.0


func update(character: CharacterBody2D, input: Vector2, delta: float) -> void:
	process_rotation(character, input, delta)
	process_velocity(character, input, delta)


func process_velocity(character: CharacterBody2D, input: Vector2, delta: float) -> void:
	var forward_input: float = input.y
	if forward_input > 0.0:
		apply_active_foward_acceleration(character, delta)
	elif forward_input < 0.0:
		apply_active_velocity_deceleration(character, delta)
	else:
		apply_passive_velocity_deceleration(character, delta)
	
	character.move_and_slide()


func process_rotation(character: CharacterBody2D, input: Vector2, delta: float) -> void:
	var rotate_input: float = input.x
	
	if input.x == 0:
		current_rotation_speed = move_toward(current_rotation_speed, 0.0, 
			passive_rotation_deceleration * delta)
	else:
		current_rotation_speed = move_toward(current_rotation_speed,
			rotate_input * max_rotation_speed, rotation_acceleration * delta)
	
	character.rotate(current_rotation_speed * delta)


func apply_active_foward_acceleration(character: CharacterBody2D, delta: float) -> void:
	var angle: float = character.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	character.velocity = character.velocity.move_toward(max_forward_speed * direction,
		foward_acceleration * delta)


func apply_active_velocity_deceleration(character: CharacterBody2D, delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO, active_velocity_deceleration * delta)


func apply_passive_velocity_deceleration(character: CharacterBody2D, delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO,
		passive_velocity_deceleration * delta)
