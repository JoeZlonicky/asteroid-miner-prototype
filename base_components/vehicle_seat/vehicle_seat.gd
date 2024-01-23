class_name VehicleSeat
extends Node2D


signal new_driver_entered(new_driver: CharacterBody2D)
signal driver_evicted(evicted_driver: CharacterBody2D)

@export var hide_driver: bool = true

var _driver: CharacterBody2D = null
var _process_mode_before: ProcessMode = Node.PROCESS_MODE_INHERIT
var _visible_before: bool = true


func set_driver(new_driver: CharacterBody2D) -> void:
	if _driver == new_driver:
		return
	
	if _driver:
		evict_driver()
	
	_driver = new_driver
	
	if _driver == null:
		return
	
	_process_mode_before = _driver.process_mode
	_driver.process_mode = Node.PROCESS_MODE_DISABLED
	
	if hide_driver:
		_visible_before = _driver.visible
		_driver.visible = false
	
	_driver.tree_exited.connect(_on_driver_tree_exited)
	_driver.global_position = global_position
	
	new_driver_entered.emit(_driver)


func get_driver() -> CharacterBody2D:
	return _driver


func evict_driver() -> void:
	if not _driver:
		return
	
	_driver.process_mode = _process_mode_before
	
	if hide_driver:
		_driver.visible = _visible_before
	
	if _driver.tree_exited.is_connected(_on_driver_tree_exited):
		_driver.tree_exited.disconnect(_on_driver_tree_exited)
	
	_driver = null
	driver_evicted.emit(_driver)


func _on_driver_tree_exited() -> void:
	evict_driver()
