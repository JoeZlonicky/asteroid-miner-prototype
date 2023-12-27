class_name ItemData
extends Resource

const PICKUP_SCENE = preload('uid://khb2p6ufatqq')

@export var name: String
@export var sprite: Texture
@export var sprite_scene: PackedScene


func create_pickup() -> Pickup:
	var pickup: Pickup = PICKUP_SCENE.instantiate()
	pickup.item_data = self
	pickup.set_sprite(sprite)
	return pickup
