class_name PlayerSpawner
extends Marker2D


signal player_spawned(player: Player)

enum SPAWN_BEHAVIOR {
	NORMAL, 
	IN_SHIP
}

@export var spawn_behavior: SPAWN_BEHAVIOR = SPAWN_BEHAVIOR.NORMAL
@export var auto_spawn: bool = true

@onready var player_node_spawner: NodeSpawner = $PlayerNodeSpawner
@onready var ship_node_spawner: NodeSpawner = $ShipNodeSpawner


func _ready() -> void:
	if auto_spawn:
		await get_tree().process_frame
		trigger()


func trigger() -> void:
	var game: Game = Utility.get_game(self)
	var player: Player = game.player
	if player == null:
		player = player_node_spawner.trigger()[0]
	
	if spawn_behavior == SPAWN_BEHAVIOR.IN_SHIP:
		var player_ship: PlayerShip = ship_node_spawner.trigger()[0]
		game.location.add_child(player_ship)
		
		if player.get_parent():
			player.reparent(player_ship, false)
		else:
			player_ship.add_child(player)
		player_ship.vehicle_seat.set_driver(player)
	else:
		game.location.add_child(player)
		player.global_position = global_position
	
	game.player = player
	player_spawned.emit(player)
