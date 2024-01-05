extends Component


const PROJECTILE_SCENE: PackedScene = preload("uid://bhpuqbiokova")

var point_index: int = 0

@onready var cooldown_timer: Timer = $Cooldown
@onready var points: Array = [
	$LeftPoint,
	$RightPoint
]

func active_update(_delta: float) -> void:
	if not Input.is_action_pressed("shoot") or not cooldown_timer.is_stopped():
		return
	
	var blaster_position: Vector2 = points[point_index].global_position
	spawn_projectile(blaster_position)
	
	point_index = wrapi(point_index + 1, 0, points.size())
	cooldown_timer.start()


func spawn_projectile(spawn_position: Vector2) -> void:
	var projectile: Projectile = PROJECTILE_SCENE.instantiate()
	entity.get_parent().add_child(projectile)
	projectile.fire(spawn_position, global_rotation - PI / 2.0, entity.velocity.length())
