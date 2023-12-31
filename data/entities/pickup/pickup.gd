class_name Pickup
extends Entity

const PASSIVE_DRIFT_SPEED: float = 20.0

var item_data: ItemData = null

var is_drifting: bool = true
var drift_velocity: Vector2

@onready var sprite: Sprite2D = $Sprite


func _ready() -> void:
	var random_angle: float = randf_range(0, 2 * PI)
	drift_velocity = Vector2(cos(random_angle), sin(random_angle)) * PASSIVE_DRIFT_SPEED


func _physics_process(delta: float) -> void:
	if not is_drifting:
		return
	
	position += drift_velocity * delta


func set_sprite(texture: Texture) -> void:
	if not is_node_ready():
		await ready
	sprite.texture = texture
