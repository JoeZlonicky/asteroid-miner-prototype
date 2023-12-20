extends Equipment


var items: Dictionary = {}  # Item name : n items


func add_item(item_name: String, n: int = 1):
	items[item_name] = items.get(item_name, 0) + n
