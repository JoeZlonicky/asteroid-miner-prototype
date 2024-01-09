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


func _on_driver_tree_exited():
	driver.process_mode = Node.PROCESS_MODE_INHERIT
	driver.visible = true
	driver.collision_shape.disabled = false
