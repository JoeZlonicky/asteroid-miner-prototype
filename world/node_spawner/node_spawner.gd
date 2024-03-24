class_name NodeSpawner
extends Node2D


enum ADD_TO {
	CURRENT_SCENE,
	NONE
}

signal nodes_spawned(nodes: Array[Node2D])

@export var scene: PackedScene = null
@export var n: int = 1
@export var auto_spawn: bool = false
@export var add_to: ADD_TO = ADD_TO.CURRENT_SCENE


func _ready() -> void:
	if auto_spawn:
		await get_tree().process_frame
		trigger()


func trigger() -> Array[Node2D]:
	var spawned: Array[Node2D] = []
	
	for i in n:
		var node: Node2D = scene.instantiate()
		node.global_position = global_position
		
		if add_to == ADD_TO.CURRENT_SCENE:
			get_tree().current_scene.add_child(node)
		
		spawned.append(node)
	
	nodes_spawned.emit(spawned)
	return spawned
