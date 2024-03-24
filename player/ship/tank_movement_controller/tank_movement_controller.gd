class_name TankMovementController
extends Node2D


enum REVERSE_BEHAVIOR {
	REVERSE,
	SLOW
}

@export var foward_acceleration: float = 320.0
@export var max_forward_speed: float = 700.0
@export var passive_velocity_deceleration: float = 10.0

@export var rotation_acceleration: float = 2.0
@export var max_rotation_speed: float = 2.0
@export var passive_rotation_deceleration: float = 2.0

@export_group("Reverse Behavior")
@export var reverse_behavior: REVERSE_BEHAVIOR = REVERSE_BEHAVIOR.REVERSE
@export var reverse_acceleration: float = 320.0
@export var max_reverse_speed: float = 700.0
@export var slow_deceleration: float = 300.0


var forward_input: float = 0.0
var rotate_input: float = 0.0

var current_rotation_speed: float = 0.0

@onready var character: CharacterBody2D = owner


func _physics_process(delta: float) -> void:
	process_rotation(delta)
	process_velocity(delta)


func process_velocity(delta: float) -> void:
	forward_input = Input.get_axis("slow_down", "move_forward")
	if forward_input > 0.0:
		active_foward_acceleration(delta)
	elif forward_input < 0.0 and reverse_behavior == REVERSE_BEHAVIOR.REVERSE:
		active_backwards_acceleration(delta)
	elif forward_input < 0.0 and reverse_behavior == REVERSE_BEHAVIOR.SLOW:
		active_slow_deceleration(delta)
	else:
		velocity_deceleration(delta)
	
	character.move_and_slide()


func process_rotation(delta: float) -> void:
	rotate_input = Input.get_axis("turn_left", "turn_right")
	
	if rotate_input == 0:
		current_rotation_speed = move_toward(current_rotation_speed, 0.0, 
			passive_rotation_deceleration * delta)
	else:
		current_rotation_speed = move_toward(current_rotation_speed,
			rotate_input * max_rotation_speed, rotation_acceleration * delta)
	
	character.rotate(current_rotation_speed * delta)


func active_foward_acceleration(delta: float) -> void:
	var angle: float = character.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	character.velocity = character.velocity.move_toward(max_forward_speed * direction,
		foward_acceleration * delta)


func active_backwards_acceleration(delta: float) -> void:
	var angle: float = character.rotation + PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	character.velocity = character.velocity.move_toward(max_reverse_speed * direction,
		reverse_acceleration * delta)


func active_slow_deceleration(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO, slow_deceleration * delta)


func velocity_deceleration(delta: float) -> void:
	character.velocity = character.velocity.move_toward(Vector2.ZERO,
		passive_velocity_deceleration * delta)
