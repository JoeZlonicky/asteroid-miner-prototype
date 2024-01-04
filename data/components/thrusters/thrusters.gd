extends Component


@export var FORWARD_THRUST: float = 320.0
@export var FORWARD_THRUST_DECELERATION: float = 10.0
@export var MAX_FORWARD_THRUST: float = 700.0

@export var SLOW_THRUST: float = 300.0

@export var ROTATION_THRUST: float = 2.0
@export var ROTATION_THRUST_DECELERATION: float = 2.0
@export var MAX_ROTATION_THRUST: float = 2.0

var current_rotation_thrust: float = 0.0

@onready var left_trail: GPUParticles2D = $LeftTrail
@onready var right_trail: GPUParticles2D = $RightTrail


func active_update(delta: float) -> void:
	left_trail.emitting = false
	right_trail.emitting = false
	process_velocity(delta)
	process_rotation(delta)


func process_velocity(delta: float) -> void:
	var forward_input: float = Input.get_axis("slow_down", "move_forward")
	if forward_input > 0.0:
		forward_thrust(delta)
	elif forward_input < 0.0:
		entity.velocity = entity.velocity.move_toward(Vector2.ZERO, SLOW_THRUST * delta)
	else:
		entity.velocity = entity.velocity.move_toward(Vector2.ZERO, FORWARD_THRUST_DECELERATION * delta)
	
	entity.move_and_slide()


func process_rotation(delta: float) -> void:
	var rotation_input: int = 0
	if Input.is_action_pressed("turn_left"):
		rotation_input -= 1
		right_trail.emitting = true
	if Input.is_action_pressed("turn_right"):
		rotation_input += 1
		left_trail.emitting = true
	
	if rotation_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			ROTATION_THRUST_DECELERATION * delta)
	else:
		current_rotation_thrust += rotation_input * ROTATION_THRUST * delta
		current_rotation_thrust = clampf(current_rotation_thrust, -MAX_ROTATION_THRUST, 
			MAX_ROTATION_THRUST)
	
	entity.rotation += current_rotation_thrust * delta


func forward_thrust(delta: float) -> void:
	var angle: float = entity.rotation - PI / 2.0
	var direction := Vector2(cos(angle), sin(angle))
	entity.velocity += FORWARD_THRUST * delta * direction
	entity.velocity = entity.velocity.limit_length(MAX_FORWARD_THRUST)
	left_trail.emitting = true
	right_trail.emitting = true
