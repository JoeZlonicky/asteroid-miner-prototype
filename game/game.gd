extends Node2D


@onready var player: CharacterBody2D = $Player


func _ready() -> void:
	DisplayServer.window_set_min_size(Vector2(800, 600))
