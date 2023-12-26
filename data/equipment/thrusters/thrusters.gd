extends Equipment


const FORWARD_THRUST: float = 200.0
const FORWARD_THRUST_DECELERATION: float = 5.0
const MAX_FORWARD_THRUST: float = 250.0

const SLOW_THRUST: float = 150.0

const ROTATION_THRUST: float = 2.0
const ROTATION_THRUST_DECELERATION: float = 2.0
const MAX_ROTATION_THRUST: float = 2.0

var current_rotation_thrust: float = 0.0

@onready var trail: GPUParticles2D = $Trail
@onready var trail2: GPUParticles2D = $Trail2


func active_update(delta: float) -> void:
	trail.emitting = false
	trail2.emitting = false
	process_velocity(delta)
	process_rotation(delta)


func process_velocity(delta: float) -> void:
	var forward_input: int = 0
	if Input.is_action_pressed("move_forward"):
		forward_input = 1
	elif Input.is_action_pressed("slow_down"):
		forward_input = -1
	
	if forward_input > 0:
		var direction := Vector2(cos(owner.rotation), sin(owner.rotation))
		owner.velocity += forward_input * FORWARD_THRUST * delta * direction
		owner.velocity = owner.velocity.limit_length(MAX_FORWARD_THRUST)
		trail.emitting = true
		trail2.emitting = true
	elif forward_input < 0:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, SLOW_THRUST * delta)
	else:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, FORWARD_THRUST_DECELERATION * delta)
	
	owner.move_and_slide()


func process_rotation(delta: float) -> void:
	var rotation_input: int = 0
	if Input.is_action_pressed("turn_left"):
		rotation_input -= 1
		trail2.emitting = true
	if Input.is_action_pressed("turn_right"):
		rotation_input += 1
		trail.emitting = true
	
	if rotation_input == 0:
		current_rotation_thrust = move_toward(current_rotation_thrust, 0.0, 
			ROTATION_THRUST_DECELERATION * delta)
	else:
		current_rotation_thrust += rotation_input * ROTATION_THRUST * delta
		current_rotation_thrust = clampf(current_rotation_thrust, -MAX_ROTATION_THRUST, 
			MAX_ROTATION_THRUST)
	owner.rotation += current_rotation_thrust * delta
