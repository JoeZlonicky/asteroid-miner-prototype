class_name Player
extends CharacterBody2D


var inventory := Inventory.new()
var movement_controller := OctagonalMovementController.new()


func _physics_process(delta: float) -> void:
	var input: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	movement_controller.update(self, input, delta)
