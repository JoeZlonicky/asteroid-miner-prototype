class_name Treads
extends Component


const MOVE_FORCE: float = 500.0
const MAX_SPEED: float = 500.0
const DECELERATION: float = 1500.0


func active_update(delta: float) -> void:
	process_velocity(delta)


func process_velocity(delta: float) -> void:
	var horizontal_input: float = Input.get_axis("move_left", "move_right")
	var vertical_input: float = Input.get_axis("move_up", "move_down")
	
	if not horizontal_input and not vertical_input:
		entity.velocity = entity.velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
		entity.move_and_slide()
		return
	
	var input := Vector2(horizontal_input, vertical_input).normalized()
	entity.velocity += input * MOVE_FORCE * delta
	entity.velocity = entity.velocity.limit_length(MAX_SPEED)
	entity.move_and_slide()
