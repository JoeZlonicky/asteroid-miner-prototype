extends Component


signal item_pickup(item: Resource)

const VACUUM_ACCELERATION: float = 200.0
const VACUUM_MAX_SPEED: float = 800.0

var affected_items = {}  # Node : current vacuum speed


func active_update(delta: float):
	for item in affected_items:
		if not is_instance_valid(item):
			affected_items.erase(item)
			continue
		
		affected_items[item] = min(affected_items[item] + VACUUM_ACCELERATION * delta,
			VACUUM_MAX_SPEED)
		
		var direction = (global_position - item.global_position).normalized()
		item.position += direction * affected_items[item] * delta


func _on_vacuum_area_body_entered(body):
	var as_pickup = body as Pickup
	if not as_pickup:
		return
	
	if not affected_items.has(as_pickup):
		affected_items[as_pickup] = 0
		as_pickup.is_drifting = false


func _on_pickup_area_body_entered(body):
	var as_pickup = body as Pickup
	if not as_pickup:
		return
		
	item_pickup.emit(as_pickup.item_data)
	as_pickup.queue_free()
