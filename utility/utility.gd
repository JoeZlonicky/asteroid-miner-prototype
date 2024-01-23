class_name Utility
extends Node


static func get_game(node_in_tree: Node) -> Game:
	var tree: SceneTree = node_in_tree.get_tree()
	if not tree:
		return null
	
	var game: Game = tree.current_scene as Game
	return game
