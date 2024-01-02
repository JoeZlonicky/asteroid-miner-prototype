extends Node2D

const MIN_WINDOW_SIZE = Vector2(800, 600)

@onready var location: Location = $Space
@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	DisplayServer.window_set_min_size(MIN_WINDOW_SIZE)


func change_location(to: PackedScene) -> void:
	var new_location: Location = to.instantiate()
	location.queue_free()
	add_child(new_location)
	move_child(new_location, 0)
	location = new_location
