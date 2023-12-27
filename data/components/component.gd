class_name Component
extends Node2D


@export var enabled: bool = true


func _physics_process(delta):
	if enabled:
		active_update(delta)


func on_equip():
	pass


func on_unequip():
	pass


func active_update(_delta: float):
	pass


func passive_update(_delta: float):
	pass
