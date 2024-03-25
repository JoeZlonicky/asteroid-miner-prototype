class_name Player
extends CharacterBody2D


var inventory := Inventory.new()
var movement_controller := OctagonalMovementController.new()


func _physics_process(delta: float) -> void:
	movement_controller.update(self, delta)
