extends Camera2D


@export var watch_player_spawner: PlayerSpawner = null


func _ready() -> void:
	if watch_player_spawner:
		watch_player_spawner.player_spawned.connect(_on_watched_player_spawner_player_spawned)


func _on_watched_player_spawner_player_spawned(player: Player) -> void:
	player.remote_transform.remote_path = get_path()
