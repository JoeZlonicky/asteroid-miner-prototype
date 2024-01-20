class_name PickupSpawnerComponent
extends Node2D


const PICKUP_SCENE: PackedScene = preload("uid://3g4olpnu6hiy")

@export var possible_items: Array[ItemData] = []
@export var n: int = 1


func spawn_pickups() -> void:
	var game: Game = get_tree().root.get_child(0)
	for i: int in n:
		var item_data: ItemData = possible_items.pick_random()
		var pickup: Pickup = PICKUP_SCENE.instantiate()
		pickup.from_item_data(item_data)
		pickup.global_position = global_position
		game.call_deferred("add_child", pickup)
