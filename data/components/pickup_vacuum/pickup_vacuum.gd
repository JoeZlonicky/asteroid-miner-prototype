extends Component


signal item_pickup(item: ItemData)

const VACUUM_ACCELERATION: float = 400.0
const VACUUM_MAX_SPEED: float = 800.0

var affected_pickups: Dictionary = {}  # Pickup : current vacuum speed


func active_update(delta: float) -> void:
	for pickup: Pickup in affected_pickups:
		if not is_instance_valid(pickup):
			affected_pickups.erase(pickup)
			continue
		
		affected_pickups[pickup] = min(affected_pickups[pickup] + VACUUM_ACCELERATION * delta,
			VACUUM_MAX_SPEED)
		
		var direction: Vector2 = (global_position - pickup.global_position).normalized()
		pickup.position += direction * affected_pickups[pickup] * delta


func _on_vacuum_area_body_entered(pickup: Pickup) -> void:
	if not affected_pickups.has(pickup):
		affected_pickups[pickup] = 0
		pickup.stop_drifting()


func _on_pickup_area_body_entered(pickup: Pickup) -> void:
	if affected_pickups.has(pickup):
		affected_pickups.erase(pickup)
	item_pickup.emit(pickup.item_data)
	pickup.queue_free()
