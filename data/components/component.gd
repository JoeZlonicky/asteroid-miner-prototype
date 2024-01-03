class_name Component
extends Node2D


@export var enabled: bool = true

@onready var entity: Entity = owner as Entity


func _physics_process(delta: float) -> void:
	if enabled:
		active_update(delta)


func on_equip() -> void:
	pass


func on_unequip() -> void:
	pass


func active_update(_delta: float) -> void:
	pass


func passive_update(_delta: float) -> void:
	pass
