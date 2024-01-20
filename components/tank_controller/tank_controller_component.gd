class_name TankControllerComponent
extends Node2D


@export var foward_thrust: float = 320.0
@export var forward_thrust_deceleration: float = 10.0
@export var max_forward_thrust: float = 700.0

@export var slow_thrust: float = 300.0

@export var rotation_thrust: float = 2.0
@export var rotation_thrust_deceleration: float = 2.0
@export var max_rotation_thrust: float = 2.0

var forward_input: float = 0.0
var rotate_input: float = 0.0

var current_rotation_thrust: float = 0.0

@onready var character: CharacterBody2D = owner


func _physics_process(delta: float) -> void:
	process_velocity(delta)
	process_rotation(delta)


func process_velocity(delta: float) -> void:
	forward_input = Input.get_axis("slow_down", "move_forward")
	if forward_input > 0.0:
		active_foward_thrust(delta)
	elif forward_input < 0.0:
		active_slow_down(delta)
	else:
		passive_slow_down(delta)
	
	character.move_and_slide()


func process_rotation(delta: float) -> void:
	rotate_input = Input.get_axis("turn_left", "turn_right")
	
	if rotate_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			rotation_thrust_deceleration * delta)
	else:
		current_rotation_thrust = move_toward(current_rotation_thrust,
			rotate_input * max_rotation_thrust, rotation_thrust * delta)
	
	character.rotate(current_rotation_thrust * delta)


func active_foward_thrust(delta: float) -> void:
	var angle: float = character.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	character.velocity = character.velocity.move_toward(max_forward_thrust * direction,
		foward_thrust * delta)


func active_slow_down(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO, slow_thrust * delta)


func passive_slow_down(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO,
		forward_thrust_deceleration * delta)
