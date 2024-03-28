extends Sprite2D


const PROJECTILE_SCENE: PackedScene = preload("uid://bhpuqbiokova")

var rotate_speed: float = 3.0
var sight_range: float = 800.0

@onready var point: Marker2D = $Point
@onready var cooldown_timer: Timer = $Cooldown


func _physics_process(delta: float) -> void:
	var nearby: Array[MathUtility.RayIntersection] = MathUtility.circular_raycast(get_world_2d().direct_space_state,
		global_position, sight_range)
	
	var nearest_distance: float = INF
	var nearest_position: Vector2 = Vector2.INF
	
	for intersection in nearby:
		if not intersection.obj is Deposit:
			continue
		
		var d: float = (intersection.pos - global_position).length()
		if d >= nearest_distance:
			continue
		
		nearest_position = intersection.pos
		nearest_distance = d
	
	var deposit_found: bool = nearest_distance < INF
	
	if not deposit_found:
		return
	
	var target_rotation: float = (nearest_position - global_position).angle() + PI / 2.0
	global_rotation = rotate_toward(global_rotation, target_rotation, rotate_speed * delta)
	
	if not cooldown_timer.is_stopped() or not deposit_found:
		return
	
	spawn_projectile(point.global_position)
	cooldown_timer.start()


func spawn_projectile(spawn_position: Vector2) -> void:
	var projectile: Projectile = PROJECTILE_SCENE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.fire(spawn_position, global_rotation - PI / 2.0)
