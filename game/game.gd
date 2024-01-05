class_name Game
extends Node2D

const MIN_WINDOW_SIZE = Vector2(800, 600)

@export var test_location: LocationData

var player: Entity = null

@onready var location: Location = null

@onready var general_hud: GeneralHUD = $GeneralHUD
@onready var ship_hud: ShipHUD = $ShipHUD
@onready var robot_hud: CanvasLayer = $RobotHUD


func _ready() -> void:
	DisplayServer.window_set_min_size(MIN_WINDOW_SIZE)
	if OS.is_debug_build() and test_location:
		change_location(test_location)


func change_location(to: LocationData) -> void:
	var new_location: Location = to.scene.instantiate()
	if location:
		location.queue_free()
	location = new_location
	location.player_spawned.connect(_on_player_spawned)
	
	add_child(new_location)
	move_child(new_location, 0)
	


func _on_player_spawned(spawned_player: Entity) -> void:
	player = spawned_player
	
	if player is PlayerShip:
		ship_hud.player_ship = player
		robot_hud.hide()
		ship_hud.show()
	else:
		ship_hud.hide()
		robot_hud.show()
