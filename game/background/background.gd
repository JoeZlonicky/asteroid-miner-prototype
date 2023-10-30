extends ParallaxBackground


@export var camera: Camera2D = null

@onready var stars: ColorRect = $ParallaxLayer/Stars


func _process(_delta: float) -> void:
	if camera == null:
		return
	
	stars.material.set("shader_parameter/camera_offset", camera.global_position)
