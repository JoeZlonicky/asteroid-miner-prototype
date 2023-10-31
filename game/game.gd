extends Node2D


@onready var player: CharacterBody2D = $Player
@onready var speed_label: Label = $HUD/SpeedLabel
@onready var transmission_container: Node2D = $Transmissions
@onready var transmission_found_animator: AnimationPlayer = $HUD/TransmissionFoundText/AnimationPlayer


func _ready() -> void:
	DisplayServer.window_set_min_size(Vector2(800, 600))
	for child in transmission_container.get_children():
		child.picked_up.connect(_on_transmission_picked_up)


func _physics_process(_delta: float) -> void:
	var player_speed: float = player.velocity.length()
	player_speed = ceilf(player_speed - 0.01)  # Offset so it doesn't occasionally +1
	player_speed = maxf(player_speed, 0.0)
	speed_label.text = str(player_speed) + "km/s"


func _on_transmission_picked_up():
	transmission_found_animator.play("fade_in_and_out")
