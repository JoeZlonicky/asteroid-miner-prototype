extends Node2D


@onready var player: CharacterBody2D = $Player
@onready var speed_label: Label = $HUD/SpeedLabel


func _ready() -> void:
	DisplayServer.window_set_min_size(Vector2(800, 600))


func _physics_process(_delta: float) -> void:
	speed_label.text = str(ceil(player.velocity.length())) + "Km/s"
