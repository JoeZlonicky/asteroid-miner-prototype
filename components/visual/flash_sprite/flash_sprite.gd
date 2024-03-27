class_name FlashSprite
extends Sprite2D


@export var flash_color: Color
@export var flash_strength: float = 1.0
@export var up_time_seconds: float = 0.1
@export var down_time_seconds: float = 0.1

var tween: Tween


func _ready() -> void:
	material.set("shader_parameter/flash_color", flash_color)


func flash() -> void:
	if tween != null:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(material, "shader_parameter/flash_strength", flash_strength, up_time_seconds)
	tween.tween_property(material, "shader_parameter/flash_strength", 0, up_time_seconds)
