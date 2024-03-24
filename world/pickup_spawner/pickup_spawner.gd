class_name PickupSpawner
extends Marker2D


@export var possible_items: Array[ItemData] = []
@export var n: int = 1

@onready var node_spawner: NodeSpawner = $NodeSpawner


func _ready() -> void:
	node_spawner.n = n


func spawn_pickups() -> void:
	var pickups: Array[Node2D] = node_spawner.trigger()
	var game: Game = null
	for pickup: Pickup in pickups:
		pickup.from_item_data(possible_items.pick_random())
		game.location.add_child(pickup)
