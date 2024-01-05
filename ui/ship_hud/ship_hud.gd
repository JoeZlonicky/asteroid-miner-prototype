class_name ShipHUD
extends CanvasLayer

const SPEED_UNIT = "m/s"

@export var player_ship: PlayerShip

@onready var speed_label: Label = $SpeedLabel


func _physics_process(_delta: float) -> void:
	if not player_ship:
		return
	
	var player_speed: float = player_ship.velocity.length()
	player_speed = ceilf(player_speed - 0.01)  # Offset so it doesn't occasionally +1
	player_speed = maxf(player_speed, 0.0)
	speed_label.text = str(player_speed) + SPEED_UNIT
