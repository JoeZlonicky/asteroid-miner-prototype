class_name Treads
extends Component


const MOVE_FORCE: float = 400.0
const MAX_SPEED: float = 500.0
const DECELERATION: float = 1500.0


func active_update(delta: float) -> void:
	process_velocity(delta)


func process_velocity(delta: float) -> void:
	var horizontal_input: float = Input.get_axis("move_left", "move_right")
	var vertical_input: float = Input.get_axis("move_up", "move_down")
	
	if abs(horizontal_input) > 0:
		owner.velocity.x += horizontal_input * MOVE_FORCE * delta
		owner.velocity.x = clamp(owner.velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0.0, DECELERATION * delta)
	
	if abs(vertical_input) > 0:
		owner.velocity.y += vertical_input * MOVE_FORCE * delta
		owner.velocity.y = clamp(owner.velocity.y, -MAX_SPEED, MAX_SPEED)
	else:
		owner.velocity.y = move_toward(owner.velocity.y, 0.0, DECELERATION * delta)

	owner.move_and_slide()
