class_name TankControllerComponent
extends Node2D


signal forward_input_received
signal left_input_received
signal right_input_received
signal slow_input_received

@export var FORWARD_THRUST: float = 320.0
@export var FORWARD_THRUST_DECELERATION: float = 10.0
@export var MAX_FORWARD_THRUST: float = 700.0

@export var SLOW_THRUST: float = 300.0

@export var ROTATION_THRUST: float = 2.0
@export var ROTATION_THRUST_DECELERATION: float = 2.0
@export var MAX_ROTATION_THRUST: float = 2.0

var current_rotation_thrust: float = 0.0

@onready var character: CharacterBody2D = owner


func _physics_process(delta: float) -> void:
	process_velocity(delta)
	process_rotation(delta)


func process_velocity(delta: float) -> void:
	var forward_input: float = Input.get_axis("slow_down", "move_forward")
	if forward_input > 0.0:
		forward_thrust(delta)
	elif forward_input < 0.0:
		slow_down(delta)
	else:
		passive_slow_down(delta)
	
	character.move_and_slide()


func process_rotation(delta: float) -> void:
	var rotation_input: int = 0
	if Input.is_action_pressed("turn_left"):
		left_input_received.emit()
		rotation_input -= 1
	if Input.is_action_pressed("turn_right"):
		right_input_received.emit()
		rotation_input += 1
	
	if rotation_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			ROTATION_THRUST_DECELERATION * delta)
	else:
		current_rotation_thrust = move_toward(current_rotation_thrust,
			rotation_input * MAX_ROTATION_THRUST, ROTATION_THRUST * delta)
	
	character.rotate(current_rotation_thrust * delta)


func forward_thrust(delta: float) -> void:
	var angle: float = character.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	character.velocity = character.velocity.move_toward(MAX_FORWARD_THRUST * direction,
		FORWARD_THRUST * delta)
	forward_input_received.emit()


func slow_down(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO, SLOW_THRUST * delta)
	slow_input_received.emit()


func passive_slow_down(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO,
		FORWARD_THRUST_DECELERATION * delta)
