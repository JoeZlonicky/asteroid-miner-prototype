extends CanvasLayer


const FAR_PARALLAX: float = 0.1
const CLOSE_PARALLAX: float = 0.5

@export var camera: Camera2D = null

@onready var far_stars: ColorRect = $FarStars
@onready var close_stars: ColorRect = $CloseStars


func _process(_delta: float) -> void:
	if camera == null:
		return
	
	far_stars.material.set("shader_parameter/camera_offset", 
		camera.global_position * FAR_PARALLAX)
	
	close_stars.material.set("shader_parameter/camera_offset", 
		camera.global_position * CLOSE_PARALLAX)
