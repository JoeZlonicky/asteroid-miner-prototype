extends ColorRect


@export var camera: Camera2D = null


func _process(_delta: float) -> void:
	if camera == null:
		return
	
	#material.set("shader_parameter/offset", camera.global_position)
