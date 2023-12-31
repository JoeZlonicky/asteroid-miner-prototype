extends Component


signal interacted

var is_player_inside: bool = false

@onready var label: Label = $Label


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and is_player_inside:
		interacted.emit()


func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body is Player:
		is_player_inside = true
		label.visible = true


func _on_trigger_area_body_exited(body: Node2D) -> void:
	if body is Player:
		is_player_inside = false
		label.visible = false
