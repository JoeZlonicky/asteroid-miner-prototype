class_name VehicleHUD
extends CanvasLayer

const SPEED_UNIT = "m/s"

@export var vehicle: Entity

@onready var speed_label: Label = $SpeedLabel


func _ready() -> void:
	hide()


func _physics_process(_delta: float) -> void:
	if not vehicle:
		return
	
	var speed: float = vehicle.velocity.length()
	speed = ceilf(speed - 0.01)  # Offset so it doesn't occasionally +1
	speed = maxf(speed, 0.0)
	speed_label.text = str(speed) + SPEED_UNIT


func set_vehicle(new_vehicle: Entity) -> void:
	vehicle = new_vehicle
	visible = (vehicle != null)
