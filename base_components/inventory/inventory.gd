class_name Inventory
extends Node


signal item_added(item_data: Resource, n: int)

@export_range(0, 999, 1) var max_n_stacks: int = -1

var items: Dictionary = {}


func add_item(item_data: Resource, n: int = 1) -> bool:
	if max_n_stacks > -1 and not items.has(item_data) and items.size() >= max_n_stacks:
		return false
	
	items[item_data] = items.get(item_data, 0) + n
	item_added.emit(item_data, n)
	return true
