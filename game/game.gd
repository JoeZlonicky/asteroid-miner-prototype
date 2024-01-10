class_name Game
extends Node2D

const MIN_WINDOW_SIZE = Vector2(800, 600)

@export var test_location: LocationData

var player: Player = null

@onready var location: Location = null

@onready var general_hud: GeneralHUD = $GeneralHUD
@onready var vehicle_hud: VehicleHUD = $VehicleHUD
@onready var robot_hud: CanvasLayer = $RobotHUD


func _ready() -> void:
	DisplayServer.window_set_min_size(MIN_WINDOW_SIZE)
	if OS.is_debug_build() and test_location:
		change_location(test_location)


func change_location(to: LocationData) -> void:
	var new_location: Location = to.scene.instantiate()
	if location:
		if player:
			player.get_parent().remove_child(player)
		location.queue_free()
	location = new_location
	location.player_spawned.connect(_on_player_spawned)
	
	add_child(new_location)
	move_child(new_location, 0)
	
	location.spawn_player(player)


func _on_player_spawned(spawned_player: Player) -> void:
	player = spawned_player
	
