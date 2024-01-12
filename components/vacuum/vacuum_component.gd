class_name VacuumComponent
extends Area2D


signal node_reached_center(node: CharacterBody2D)

var vacuum_start_speed: float = 0.0
var vacuum_acceleration: float = 400.0
var vacuum_max_speed: float = 800.0

var affected_nodes: Dictionary = {}  # CharacterBody2D : current vacuum speed

@onready var center_area: Area2D = $CenterArea


func _ready() -> void:
	center_area.collision_mask = collision_mask


func _physics_process(delta: float) -> void:
	for node: CharacterBody2D in affected_nodes:
		affected_nodes[node] = min(affected_nodes[node] + vacuum_acceleration * delta,
			vacuum_max_speed)
		
		var direction: Vector2 = (global_position - node.global_position).normalized()
		node.velocity = direction * affected_nodes[node]
		node.move_and_slide()


func _on_body_entered(body: Node2D) -> void:
	if not body is CharacterBody2D:
		return
	
	if not affected_nodes.has(body):
		affected_nodes[body] = vacuum_start_speed
		body.tree_exiting.connect(_on_node_tree_exiting.bind(body))


func _on_center_area_body_entered(body: Node2D) -> void:
	if affected_nodes.has(body):
		node_reached_center.emit(body)


func _on_node_tree_exiting(node: Node2D) -> void:
	affected_nodes.erase(node)
