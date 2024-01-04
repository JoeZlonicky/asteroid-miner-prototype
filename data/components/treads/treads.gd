class_name Treads
extends Component


const MOVE_SPEED: float = 650.0
const ROTATION_SPEED: float = 10.0

var last_input_direction: Vector2 = Vector2.ZERO


func active_update(delta: float) -> void:
	var horizontal_input: float = Input.get_axis("move_left", "move_right")
	var vertical_input: float = Input.get_axis("move_up", "move_down")
	var input := Vector2(horizontal_input, vertical_input)
	
	process_velocity(input, delta)
	process_rotation(input, delta)


func process_velocity(input_vector: Vector2, _delta: float) -> void:
	if input_vector:
		entity.velocity = input_vector.normalized() * MOVE_SPEED
	else:
		entity.velocity = Vector2.ZERO
	entity.move_and_slide()


func process_rotation(input_vector: Vector2, delta: float) -> void:
	if input_vector:
		last_input_direction = input_vector.normalized()
	
	if not last_input_direction:
		return
	
	entity.rotation = rotate_toward(entity.rotation, last_input_direction.angle() + PI / 2.0,
		ROTATION_SPEED * delta)
