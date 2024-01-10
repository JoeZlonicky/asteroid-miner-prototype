class_name VehicleComponent
extends Component


var driver: Entity = null


func set_driver(new_driver: Entity):
	driver = new_driver
	driver.process_mode = Node.PROCESS_MODE_DISABLED
	driver.visible = false
	driver.collision_shape.disabled = true
	driver.tree_exited.connect(_on_driver_tree_exited, CONNECT_ONE_SHOT)
	driver.global_position = entity.global_position
	
	var game: Game = get_tree().current_scene as Game
	game.vehicle_hud.set_vehicle(entity)


func _on_driver_tree_exited():
	driver.process_mode = Node.PROCESS_MODE_INHERIT
	driver.visible = true
	driver.collision_shape.disabled = false
	
	var tree: SceneTree = get_tree()
	if not tree:
		return
	
	var game: Game = tree.current_scene as Game
	if not game:
		return
	
	game.vehicle_hud.set_vehicle(null)
