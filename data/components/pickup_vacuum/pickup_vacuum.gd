extends Component


signal item_pickup(item: ItemData)

const VACUUM_ACCELERATION: float = 200.0
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


func _on_vacuum_area_body_entered(body: Node2D) -> void:
	var as_pickup: Pickup = body as Pickup
	if not as_pickup:
		return
	
	if not affected_pickups.has(as_pickup):
		affected_pickups[as_pickup] = 0
		as_pickup.is_drifting = false


func _on_pickup_area_body_entered(body: Node2D) -> void:
	var as_pickup: Pickup = body as Pickup
	if not as_pickup:
		return
		
	item_pickup.emit(as_pickup.item_data)
	as_pickup.queue_free()
