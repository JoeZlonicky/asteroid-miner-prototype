extends ColorRect


@export var parallax_strength: float = 0.0

var camera: Camera2D = null


func _ready() -> void:
	camera = get_viewport().get_camera_2d()


func _process(_delta: float) -> void:
	if camera == null:
		return
	
	material.set("shader_parameter/camera_offset", camera.global_position * parallax_strength)
