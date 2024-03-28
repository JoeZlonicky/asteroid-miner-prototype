class_name Asteroid
extends StaticBody2D


const DEPOSIT_SCENE: PackedScene = preload("uid://bexehsklkaj8i")

@export var data: AsteroidData

@onready var sprite: Sprite2D = $Sprite
@onready var collision_polygon: CollisionPolygon2D = $CollisionPolygon2D


func _ready() -> void:
	if data == null:
		return
	
	sprite.texture = data.sprite
	collision_polygon.polygon = data.collision
	
	for point in data.deposit_spawn_locations:
		var deposit: Deposit = DEPOSIT_SCENE.instantiate()
		deposit.data = data.deposit_data
		deposit.show_behind_parent = true
		add_child(deposit)
		deposit.position = point
		deposit.rotation = deposit.position.angle() + PI / 2.0
