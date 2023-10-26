class_name Player
extends CharacterBody2D


const PROJECTILE_SCENE: PackedScene = preload("res://projectile/projectile.tscn")

const FORWARD_THRUST: float = 2.0
const FORWARD_THRUST_DECELERATION: float = 1.0
const MAX_FORWARD_THRUST: float = 200.0

const ROTATION_THRUST: float = 2.0
const ROTATION_THRUST_DECELERATION: float = 2.0
const MAX_ROTATION_THRUST: float = 2.0

var current_rotation_thrust: float = 0.0
var blaster_i: int = 0

@onready var blaster_cooldown: Timer = $BlasterCooldown
@onready var blasters: Array = [
	$Blasters/FrontLeft,
	$Blasters/FrontRight,
	$Blasters/BackLeft,
	$Blasters/BackRight
]


func _physics_process(delta: float) -> void:
	process_rotation(delta)
	process_velocity(delta)
	process_blasters()


func process_velocity(_delta: float) -> void:
	var forward_input: int = 0
	if Input.is_action_pressed("move_forward"):
		forward_input = 1
	
	if forward_input == 0:
		velocity = velocity.move_toward(Vector2.ZERO, FORWARD_THRUST_DECELERATION)
	else:
		velocity += forward_input * FORWARD_THRUST * Vector2(cos(rotation), sin(rotation))
		velocity = velocity.limit_length(MAX_FORWARD_THRUST)
	
	move_and_slide()


func process_rotation(delta: float) -> void:
	var rotation_input: int = 0
	if Input.is_action_pressed("turn_left"):
		rotation_input -= 1
	if Input.is_action_pressed("turn_right"):
		rotation_input += 1
	
	if rotation_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			ROTATION_THRUST_DECELERATION * delta)
	else:
		current_rotation_thrust += rotation_input * ROTATION_THRUST * delta
		current_rotation_thrust = clampf(current_rotation_thrust, -MAX_ROTATION_THRUST, 
			MAX_ROTATION_THRUST)
	rotation += current_rotation_thrust * delta


func process_blasters() -> void:
	if not Input.is_action_pressed("shoot"):
		return
	
	if not blaster_cooldown.is_stopped():
		return
	
	var blaster_position: Vector2 = blasters[blaster_i].global_position
	spawn_projectile(blaster_position)
	blaster_i = wrapi(blaster_i + 1, 0, blasters.size())
	blaster_cooldown.start()


func spawn_projectile(spawn_position: Vector2) -> void:
	var projectile = PROJECTILE_SCENE.instantiate()
	get_parent().add_child(projectile)
	projectile.fire(spawn_position, rotation, velocity.length())
