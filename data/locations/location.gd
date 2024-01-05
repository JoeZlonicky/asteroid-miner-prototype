class_name Location
extends Node2D


signal player_spawned(player: Entity)

const PLAYER_SHIP_SCENE: PackedScene = preload("res://data/entities/player_ship/player_ship.tscn")
const PLAYER_ROBOT_SCENE: PackedScene = preload("res://data/entities/player_robot/player_robot.tscn")

@onready var camera: Camera2D = $Camera2D
@onready var default_player_spawn_marker: PlayerSpawnMarker = $DefaultPlayerSpawnMarker


func _ready() -> void:
	spawn_player()


func spawn_player() -> void:
	var player: Entity = null
	
	if default_player_spawn_marker.spawn_type == PlayerSpawnMarker.SPAWN_TYPE.SHIP:
		player = PLAYER_SHIP_SCENE.instantiate()
	else:
		player = PLAYER_ROBOT_SCENE.instantiate()
	
	add_child(player)
	player.global_position = default_player_spawn_marker.global_position
	
	var remote_transform: RemoteTransform2D = RemoteTransform2D.new()
	player.add_child(remote_transform)
	remote_transform.remote_path = camera.get_path()
	
	player_spawned.emit(player)
