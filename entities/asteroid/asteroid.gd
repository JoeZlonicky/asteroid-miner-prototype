class_name Asteroid
extends StaticBody2D


@export var flash_sprite: FlashSprite
@export var pickup_spawner: PickupSpawner

var health := Health.new(20)


func _ready() -> void:
	health.died.connect(_on_death)
	health.damaged.connect(_on_hit)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		health.take_damage(1)


func _on_hit(_amount: int) -> void:
	flash_sprite.flash()


func _on_death() -> void:
	pickup_spawner.spawn_pickups.call_deferred()
	queue_free()
