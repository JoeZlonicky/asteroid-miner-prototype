class_name Player
extends CharacterBody2D


@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var inventory: InventoryComponent = $Inventory
@onready var remote_transform: RemoteTransform2D = $RemoteTransform2D
