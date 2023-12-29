extends Component


const PROJECTILE_SCENE: PackedScene = preload("uid://drufal4f2uggw")

var point_index: int = 0

@onready var cooldown_timer: Timer = $Cooldown
@onready var points: Array = [
	$Point1,
	$Point2
]

func active_update(_delta: float) -> void:
	if not Input.is_action_pressed("shoot"):
		return
	
	if not cooldown_timer.is_stopped():
		return
	
	var blaster_position: Vector2 = points[point_index].global_position
	spawn_projectile(blaster_position)
	point_index = wrapi(point_index + 1, 0, points.size())
	cooldown_timer.start()


func spawn_projectile(spawn_position: Vector2) -> void:
	var projectile = PROJECTILE_SCENE.instantiate()
	owner.get_parent().add_child(projectile)
	projectile.fire(spawn_position, global_rotation, owner.velocity.length())
