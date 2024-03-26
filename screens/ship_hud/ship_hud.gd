class_name VehicleHUD
extends CanvasLayer

const SPEED_UNIT = "m/s"

@export var ship: CharacterBody2D

@onready var speed_label: Label = $SpeedLabel


func _physics_process(_delta: float) -> void:
	if not ship:
		return
	
	var speed: float = ship.velocity.length()
	speed = ceilf(speed - 0.01)  # Offset so it doesn't occasionally +1
	speed = maxf(speed, 0.0)
	speed_label.text = str(speed) + SPEED_UNIT
