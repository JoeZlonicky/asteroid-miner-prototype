class_name InventoryComponent
extends Node


signal item_added(item_data: ItemData, n: int)


var items: Dictionary = {}


func add_item(item_data: ItemData, n: int = 1) -> bool:
	items[item_data] = items.get(item_data, 0) + n
	item_added.emit(item_data, n)
	return true
