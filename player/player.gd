class_name Player
extends CharacterBody2D




@onready var blaster: Equipment = $Blaster
@onready var engines: Equipment = $StandardEngine


func _physics_process(delta: float) -> void:
	engines.active_update(delta)
	blaster.active_update(delta)
