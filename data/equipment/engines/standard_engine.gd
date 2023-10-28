extends Equipment


const FORWARD_THRUST: float = 200.0
const FORWARD_THRUST_DECELERATION: float = 100.0
const MAX_FORWARD_THRUST: float = 200.0

const ROTATION_THRUST: float = 2.0
const ROTATION_THRUST_DECELERATION: float = 2.0
const MAX_ROTATION_THRUST: float = 2.0

var current_rotation_thrust: float = 0.0


func active_update(delta: float) -> void:
	process_velocity(delta)
	process_rotation(delta)


func process_velocity(delta: float) -> void:
	var forward_input: int = 0
	if Input.is_action_pressed("move_forward"):
		forward_input = 1
	
	if forward_input == 0:
		owner.velocity = owner.velocity.move_toward(Vector2.ZERO, FORWARD_THRUST_DECELERATION * delta)
	else:
		owner.velocity += forward_input * FORWARD_THRUST * delta * Vector2(cos(owner.rotation), sin(owner.rotation))
		owner.velocity = owner.velocity.limit_length(MAX_FORWARD_THRUST)
	
	owner.move_and_slide()


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
	owner.rotation += current_rotation_thrust * delta
