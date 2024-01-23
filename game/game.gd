class_name Game
extends Node2D

const MIN_WINDOW_SIZE = Vector2(800, 600)

@export var test_location: LocationData

var player: Player = null

@onready var location: Node2D = null

@onready var general_hud: GeneralHUD = $GeneralHUD
@onready var vehicle_hud: VehicleHUD = $VehicleHUD


func _ready() -> void:
	DisplayServer.window_set_min_size(MIN_WINDOW_SIZE)
	if OS.is_debug_build() and test_location:
		change_location(test_location)


func change_location(to: LocationData) -> void:
	var new_location: Node2D = to.scene.instantiate()
	if location:
		if player:
			player.get_parent().remove_child(player)
		location.queue_free()
	location = new_location
	
	add_child(new_location)
	move_child(new_location, 0)
