class_name Player
extends CharacterBody2D


const FORWARD_THRUST: float = 2.0
const FORWARD_THRUST_DECELERATION: float = 1.0
const MAX_FORWARD_THRUST: float = 200.0

const ROTATION_THRUST: float = 0.001
const ROTATION_THRUST_DECELERATION: float = 0.001
const MAX_ROTATION_THRUST: float = 0.02

var current_rotation_thrust: float = 0.0


func _process(_delta: float) -> void:
	var forward_input: int = 0
	if Input.is_action_pressed("move_forward"):
		forward_input = 1
	
	var rotation_input: int = 0
	if Input.is_action_pressed("turn_left"):
		rotation_input -= 1
	if Input.is_action_pressed("turn_right"):
		rotation_input += 1
	
	if rotation_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			ROTATION_THRUST_DECELERATION)
	else:
		current_rotation_thrust += rotation_input * ROTATION_THRUST
		current_rotation_thrust = clampf(current_rotation_thrust, -MAX_ROTATION_THRUST, 
			MAX_ROTATION_THRUST)
	rotation += current_rotation_thrust
	
	if forward_input == 0:
		velocity = velocity.move_toward(Vector2.ZERO, FORWARD_THRUST_DECELERATION)
	else:
		velocity += forward_input * FORWARD_THRUST * Vector2(cos(rotation), sin(rotation))
		velocity = velocity.limit_length(MAX_FORWARD_THRUST)
	
	move_and_slide()
