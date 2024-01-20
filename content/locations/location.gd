class_name Location
extends Node2D


signal player_spawned(player: Player)

const PLAYER_SHIP_SCENE: PackedScene = preload("uid://2cs02ipd30sh")
const PLAYER_SCENE: PackedScene = preload("uid://dw2bw2mehkoi5")

@onready var camera: Camera2D = $Camera2D
@onready var default_player_spawn_marker: PlayerSpawnMarker = $DefaultPlayerSpawnMarker


func spawn_player(player: Player = null) -> void:
	if not player:
		player = PLAYER_SCENE.instantiate()
	
	if default_player_spawn_marker.spawn_type == PlayerSpawnMarker.SPAWN_TYPE.SHIP:
		var player_ship: PlayerShip = PLAYER_SHIP_SCENE.instantiate()
		player_ship.global_position = default_player_spawn_marker.global_position
		add_child(player_ship)
		player_ship.add_child(player)
		player_ship.vehicle_component.set_driver(player)
	else:
		add_child(player)
		player.global_position = default_player_spawn_marker.global_position
	
	player.remote_transform.remote_path = camera.get_path()
	player_spawned.emit(player)
